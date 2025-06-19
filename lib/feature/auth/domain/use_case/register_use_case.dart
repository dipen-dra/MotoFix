import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:motofix_app/app/usecase/usecase.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:motofix_app/feature/auth/domain/repository/user_repository.dart';


class RegisterUserParams extends Equatable {
  final String name;
  final String phone;
  final String password;
  final String email;

  const RegisterUserParams({
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
  });

  const RegisterUserParams.initial({
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, phone, password, email];
}

class UserRegisterUseCase
    implements UseCaseWithParams<void, RegisterUserParams> {
  final IUserRepository _userRepository;

  UserRegisterUseCase({required IUserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final userEntity = UserEntity(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone,
    );

    return _userRepository.registerUser(userEntity);
  }
}