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
import 'package:motofix_app/feature/customer_service/data/data_source/remote_data_source/service_remote_data_source.dart';
import 'package:motofix_app/feature/customer_service/data/dto/get_all_service_dto.dart';
import 'package:motofix_app/feature/customer_service/data/repository/remote_repository/service_remote_repository.dart';
import 'package:motofix_app/feature/customer_service/domain/usecase/get_all_services_usecase.dart';
import 'package:motofix_app/feature/customer_service/presentation/view_model/service_view_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/auth/domain/use_case/user_delete_usecase.dart';
import '../../feature/auth/domain/use_case/user_get_usecase.dart';
import '../../feature/auth/domain/use_case/user_update_usecase.dart';
import '../../feature/auth/presentation/view_model/profile_view_model/profile_view_model.dart';
import '../../feature/booking/data/data_source/remote_data_source/remote_booking_data_source.dart';
import '../../feature/booking/data/repository/remote_repository/booking_remote_repository.dart';
import '../../feature/booking/domain/repository/booking_repository.dart';
import '../../feature/booking/domain/use_case/create_user_bookings.dart';
import '../../feature/booking/domain/use_case/delete_user_bookings.dart';
import '../../feature/booking/domain/use_case/get_user_bookings.dart';
import '../../feature/booking/presentation/view_model/booking_view_model.dart';
import '../shared_pref/token_shared_prefs.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  await _initAuthModule();
  await _initApiService() ;
  await _initBookingModule() ;
  await _initSharedPrefs() ;
  await _initServiceModule() ;

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
            userRepository: serviceLocator<UserRemoteRepository>(), tokenSharedPrefs: serviceLocator<TokenSharedPrefs>()),
  );



  serviceLocator.registerFactory(
        () =>
        UserRegisterUseCase(
          userRepository: serviceLocator<UserRemoteRepository>(),
        ),
  );

  serviceLocator.registerFactory(
        () => UserGetUseCase(
      iUserRepository: serviceLocator<UserRemoteRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );
  serviceLocator.registerFactory(
        () => UserUpdateUsecase(
      iUserRepository: serviceLocator<UserRemoteRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );
  serviceLocator.registerFactory(
        () => UserDeleteUsecase(
      iUserRepository: serviceLocator<UserRemoteRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
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

  serviceLocator.registerFactory(
        () => ProfileViewModel(
      userGetUseCase: serviceLocator<UserGetUseCase>(),
      userUpdateUseCase: serviceLocator<UserUpdateUsecase>(),
      userDeleteUsecase: serviceLocator<UserDeleteUsecase>(),
    ),
  );

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
          () => serviceLocator<BookingRepository>(),
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
        () => GetUserBookings(bookingRepository: serviceLocator<BookingRemoteRepository>() , tokenSharedPrefs: serviceLocator<TokenSharedPrefs>())
    ) ;
    serviceLocator.registerFactory(
          () => DeleteBookingUsecase(bookingRepository: serviceLocator<BookingRemoteRepository>() ,
            tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),),
    );

    serviceLocator.registerFactory(
        () => CreateBookingUseCase(bookingRepository: serviceLocator<BookingRemoteRepository>(), tokenSharedPrefs: serviceLocator<TokenSharedPrefs>()) ,
    ) ;

    // ===================== ViewModel (BLoC) ====================
    serviceLocator.registerFactory<BookingViewModel>(
          () => BookingViewModel(
        getUserBookingsUseCase: serviceLocator<GetUserBookings>(),
        deleteBookingUseCase: serviceLocator<DeleteBookingUsecase>(), createBookingUseCase: serviceLocator<CreateBookingUseCase>() ,
      ),
    );
  }

Future<void> _initServiceModule() async {

  serviceLocator.registerFactory(
        () => ServiceRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  serviceLocator.registerFactory<ServiceRemoteRepository>(
        () => ServiceRemoteRepository(
      serviceRemoteDataSource: serviceLocator<ServiceRemoteDataSource>(),
    ),
  );

  // Usecases
  serviceLocator.registerFactory(
        () => GetAllServicesUsecase(
      serviceRepository: serviceLocator<ServiceRemoteRepository>(),
            tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );
  serviceLocator.registerFactory<ServiceViewModel>(
        () => ServiceViewModel(
      getAllServicesUsecase: serviceLocator<GetAllServicesUsecase>(),
    ),
  );
}

