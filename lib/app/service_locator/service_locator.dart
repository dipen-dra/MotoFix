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

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  await _initAuthModule();
  await _initApiService() ;
}

Future _initHiveService() async {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}

Future _initApiService() async {
  serviceLocator.registerLazySingleton<ApiService>(() => ApiService(Dio()));
}

Future<void> _initAuthModule() async {
  // ===================== Data Source ====================
  // serviceLocator.registerFactory(
  //   () => UserLocalDataSource(hiveService: serviceLocator<HiveService>()),
  // );
  //
  serviceLocator.registerFactory(
      () => UserRemoteDataSource(apiService: serviceLocator<ApiService>())
  ) ;

  // ===================== Repository ====================
  //
  // serviceLocator.registerFactory(
  //   () => UserLocalRepository(
  //     userLocalDataSource: serviceLocator<UserLocalDataSource>(),
  //   ),
  // );

  serviceLocator.registerFactory(
      () => UserRemoteRepository(userRemoteDataSource: serviceLocator<UserRemoteDataSource>()),
  ) ;

  serviceLocator.registerFactory(
    () =>
        UserLoginUseCase(userRepository: serviceLocator<UserRemoteRepository>()),
  );

  serviceLocator.registerFactory(
    () => UserRegisterUseCase(
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

// Future<void> _initHomeModule() async {
//   serviceLocator.registerFactory(
//     () => HomeViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
//   );
// }
}
