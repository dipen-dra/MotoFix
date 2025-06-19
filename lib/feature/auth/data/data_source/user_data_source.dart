import 'package:motofix_app/feature/auth/domain/entity/auth_entity.dart';

abstract class IUserDataSource {
  Future<void> registerUser(UserEntity user);

  Future<String> loginUser(String email, String password);
}