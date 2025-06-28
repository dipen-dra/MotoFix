import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:motofix_app/core/network/api_service.dart';
import 'package:motofix_app/core/network/hive_service.dart';
import 'package:motofix_app/feature/auth/data/data_source/local_data_source/local_data_source.dart';
import 'package:motofix_app/feature/auth/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:motofix_app/feature/auth/data/repository/local_user_repository.dart';
import 'package:motofix_app/feature/auth/data/repository/remote_user_repository.dart';
import 'package:motofix_app/feature/auth/domain/use_case/login_use_case.dart';
import 'package:motofix_app/feature/auth/domain/use_case/register_use_case.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:motofix_app/feature/service/data/data_source/remote_data_source/remote_booking_data_source.dart';
import 'package:motofix_app/feature/service/data/repository/remote_repository/booking_remote_repository.dart';
import 'package:motofix_app/feature/service/domain/use_case/create_user_bookings.dart';
import 'package:motofix_app/feature/service/domain/use_case/delete_user_bookings.dart';
import 'package:motofix_app/feature/service/domain/use_case/get_user_bookings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/service/domain/repository/booking_repository.dart';
import '../../feature/service/presentation/view_model/booking_view_model.dart';
import '../shared_pref/token_shared_prefs.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  await _initAuthModule();
  await _initApiService() ;
  await _initBookingModule() ;
  await _initSharedPrefs() ;

}

Future _initHiveService() async {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}

Future _initApiService() async {
  serviceLocator.registerLazySingleton<ApiService>(() => ApiService(Dio()));
}

Future<void> _initSharedPrefs() async {
  // Initialize Shared Preferences if needed
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPrefs);
  serviceLocator.registerLazySingleton(
        () => TokenSharedPrefs(
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
}

Future<void> _initAuthModule() async {
  // ===================== Data Source ====================
  // serviceLocator.registerFactory(
  //   () => UserLocalDataSource(hiveService: serviceLocator<HiveService>()),
  // );
  //
  serviceLocator.registerFactory(
          () => UserRemoteDataSource(apiService: serviceLocator<ApiService>())
  );

  // ===================== Repository ====================
  //
  // serviceLocator.registerFactory(
  //   () => UserLocalRepository(
  //     userLocalDataSource: serviceLocator<UserLocalDataSource>(),
  //   ),
  // );

  serviceLocator.registerFactory(
        () =>
        UserRemoteRepository(
        userRemoteDataSource: serviceLocator<UserRemoteDataSource>()),
  );

  serviceLocator.registerFactory(
        () =>
        UserLoginUseCase(
            userRepository: serviceLocator<UserRemoteRepository>()),
  );

  serviceLocator.registerFactory(
        () =>
        UserRegisterUseCase(
          userRepository: serviceLocator<UserRemoteRepository>(),
        ),
  );

  // ===================== ViewModels ====================

  serviceLocator.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(serviceLocator<UserRegisterUseCase>()),
  );

//   // Register LoginViewModel WITHOUT HomeViewModel to avoid circular dependency
  serviceLocator.registerFactory(
        () => LoginViewModel(serviceLocator<UserLoginUseCase>()),
  );
// }
// }
}
// Future<void> _initHomeModule() async {
//   serviceLocator.registerFactory(
//     () => HomeViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
//   );
// }

  Future<void> _initBookingModule() async {
    // ===================== Data Source ====================
    // Assumes you have a BookingRemoteDataSource that talks to your API


    // ===================== Repository ====================
    // serviceLocator.registerFactory<BookingRepository>(
    //       () => BookingRepositoryImpl(
    //     bookingRemoteDataSource: serviceLocator<BookingRemoteDataSource>(),
    //   ),
    // );
    serviceLocator.registerFactory<BookingRepository>(
          () => serviceLocator<BookingRemoteRepository>(),
    );

    // ===================== Use Cases ====================
    serviceLocator.registerFactory(
          () => RemoteBookingDataSource(apiService: serviceLocator<ApiService>()),
    );

    serviceLocator.registerFactory<BookingRemoteRepository>(
          () => BookingRemoteRepository(
        remoteBookingDataSource: serviceLocator<RemoteBookingDataSource>(),
      ),
    );


    serviceLocator.registerFactory(
        () => GetUserBookings(bookingRepository: serviceLocator<BookingRemoteRepository>())
    ) ;
    serviceLocator.registerFactory(
          () => DeleteBookingUsecase(bookingRepository: serviceLocator<BookingRemoteRepository>() ,
            tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),),
    );

    serviceLocator.registerFactory(
        () => CreateBookingUseCase(bookingRepository: serviceLocator<BookingRemoteRepository>()) ,
    ) ;

    // ===================== ViewModel (BLoC) ====================
    serviceLocator.registerFactory<BookingViewModel>(
          () => BookingViewModel(
        getUserBookingsUseCase: serviceLocator<GetUserBookings>(),
        deleteBookingUseCase: serviceLocator<DeleteBookingUsecase>(),
            createBookingUseCase: serviceLocator<CreateBookingUseCase>() ,
      ),
    );
  }

