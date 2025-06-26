import 'package:dio/dio.dart';
import 'package:motofix_app/feature/auth/data/model/user_api_model.dart';
import 'package:motofix_app/feature/auth/domain/entity/auth_entity.dart';

import '../../../../../app/constant/api_endpoints.dart';
import '../../../../../core/network/api_service.dart';
import '../user_data_source.dart';


class UserRemoteDataSource implements IUserDataSource {
  final ApiService _apiService;

  UserRemoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(
          "Failed to login user : ${response.statusMessage}",
        );
      }
    } on DioException catch (e) {
      throw Exception("Failed to Login user : ${e.message}");
    } catch (e) {
      throw Exception("failed to login user $e");
    }
  }

  @override
  Future<void> registerUser(UserEntity user) async {
    try {
      final userApiModel = UserApiModel.fromEntity(user);
      final response = await _apiService.dio.post(
        ApiEndpoints.register,
        // 3. Send the user data as JSON in the request body.
        data: userApiModel.toJson(),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
            "Failed to register user : ${response.statusMessage}");
      }
    }
    on DioException catch (e) {
      throw Exception("Failed to register user : ${e.message}");
    } catch (e) {
      throw Exception('Failed to register student : $e');
    }

    // @override
    // Future<void> createUser(UserEntity entity) async {
    //   try {
    //     final userApiModel = UserApiModel.fromEntity(entity);
    //     final response = await _apiService.dio.post(
    //       ApiEndpoints.register,
    //       data: userApiModel.toJson(),
    //     );
    //     if (response.statusCode == 200) {
    //       return;
    //     } else {
    //       throw Exception("Failed to register user : ${response.statusMessage}");
    //     }
    //   } on DioException catch (e) {
    //     throw Exception("Failed to register user : ${e.message}");
    //   } catch (e) {
    //     throw Exception('Failed to register student : $e');
    //   }
    // }

    // @override
    // Future<void> deleteUser(String id) {
    //   // TODO: implement deleteUser
    //   throw UnimplementedError();
    // }
    //
    // @override
    // Future<List<UserEntity>> getAllUser() {
    //   // TODO: implement getAllUser
    //   throw UnimplementedError();
    // }

    // @override
    // Future<void> loginUser(String email, String password) async {
    //   try {
    //     final response = await _apiService.dio.post(
    //       ApiEndpoints.login,
    //       data: {'email': email, 'password': password},
    //     );
    //
    //     if (response.statusCode == 200) {
    //       final str = response.data['token'];
    //       return str;
    //     } else {
    //       throw Exception(
    //         "Failed to registerr student : ${response.statusMessage}",
    //       );
    //     }
    //   } on DioException catch (e) {
    //     throw Exception("Failed to Login Student : ${e.message}");
    //   } catch (e) {
    //     throw Exception("failed to login user $e");
    //   }
    // }
    //
    // @override
    // Future<void> registerUser(UserEntity entity) async {
    //   try {
    //     final userApiModel = UserApiModel.fromEntity(entity);
    //
    //   } catch (e) {
    //     throw Exception('Registratin Failed  : $e');
    //   }
    // }
  }
}