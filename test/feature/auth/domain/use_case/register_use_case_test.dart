import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:motofix_app/feature/auth/domain/repository/user_repository.dart';
import 'package:motofix_app/feature/auth/domain/use_case/register_use_case.dart';

// Mock for the repository
class MockUserRepository extends Mock implements IUserRepository {}

// A "Fake" class that can be used as a placeholder for UserEntity.
// This is a best-practice approach suggested by the mocktail docs.
class FakeUserEntity extends Fake implements UserEntity {}

void main() {
  late UserRegisterUseCase usecase;
  late MockUserRepository mockUserRepository;

  // This block runs once before any tests
  setUpAll(() {
    // Teach mocktail how to create a dummy UserEntity when `any()` is used.
    registerFallbackValue(FakeUserEntity());
  });

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UserRegisterUseCase(userRepository: mockUserRepository);
  });

  // Test data remains the same
  const tFullName = 'Binod';
  const tEmail = 'binod@gmail.com';
  const tPassword = 'password123';

  final tRegisterParams = RegisterUserParams(
    fullName: tFullName,
    email: tEmail,
    password: tPassword,
  );

  const tUserEntity = UserEntity(
    fullName: tFullName,
    email: tEmail,
    password: tPassword,
  );

  test(
    'should call UserRepository.registerUser with the correct UserEntity and return success',
    () async {
      // Arrange
      // This `any()` is what requires the fallback value.
      when(() => mockUserRepository.registerUser(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(tRegisterParams);

      // Assert
      expect(result, const Right(null));
      verify(() => mockUserRepository.registerUser(tUserEntity)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    },
  );

  test(
    'should return a Failure when the repository fails',
    () async {
      // Arrange
      const apiFailure = ApiFailure(message: 'Server Error', statusCode: 500);
      // This `any()` also requires the fallback value.
      when(() => mockUserRepository.registerUser(any()))
          .thenAnswer((_) async => const Left(apiFailure));

      // Act
      final result = await usecase(tRegisterParams);

      // Assert
      expect(result, const Left(apiFailure));
      verify(() => mockUserRepository.registerUser(tUserEntity)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}