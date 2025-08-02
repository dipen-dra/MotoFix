import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/app/shared_pref/token_shared_prefs.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:motofix_app/feature/auth/domain/repository/user_repository.dart';
import 'package:motofix_app/feature/auth/domain/use_case/user_update_usecase.dart';

// Mocks from separate files
class MockUserRepository extends Mock implements IUserRepository {}
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

// A Fake class for registering a fallback value with mocktail
class FakeUserEntity extends Fake implements UserEntity {}

void main() {
  late UserUpdateUsecase usecase;
  late MockUserRepository mockUserRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  // This runs once before all tests
  setUpAll(() {
    // Register a fallback value for UserEntity to allow `any()` matcher
    registerFallbackValue(FakeUserEntity());
  });

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    usecase = UserUpdateUsecase(
      iUserRepository: mockUserRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  const tToken = 'sample_auth_token';
  // The user data we are trying to send for the update
  const tUserEntityParams = UserEntity(
    userId: '1',
    fullName: 'New Name',
    email: 'new@email.com',
    password: 'new_password',
  );
  // The user data we expect back after a successful update
  const tUpdatedUserEntityResult = UserEntity(
    userId: '1',
    fullName: 'New Name',
    email: 'new@email.com',
    password: '', // Password is often not returned
    phone: '1234567890',
  );
  
  const tApiFailure = ApiFailure(message: 'Update failed', statusCode: 500);
  const tCacheFailure = ApiFailure(message: 'Token not found', statusCode: 500);

  test(
    'should get token and successfully update user data in the repository',
    () async {
      // Arrange
      // 1. Stub getToken to return a valid token
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));
      // 2. Stub updateUser to return the updated UserEntity
      when(() => mockUserRepository.updateUser(any(), any()))
          .thenAnswer((_) async => const Right(tUpdatedUserEntityResult));

      // Act
      final result = await usecase(tUserEntityParams);

      // Assert
      // 1. Expect the successful result from the repository
      expect(result, const Right(tUpdatedUserEntityResult));
      // 2. Verify getToken was called
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      // 3. Verify updateUser was called with the correct parameters
      verify(() => mockUserRepository.updateUser(tUserEntityParams, tToken)).called(1);
      // 4. Ensure no other interactions occurred
      verifyNoMoreInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );

  test(
    'should return Failure when token retrieval fails',
    () async {
      // Arrange
      // 1. Stub getToken to return a failure
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Left(tCacheFailure));

      // Act
      final result = await usecase(tUserEntityParams);

      // Assert
      // 1. Expect the failure from shared prefs
      expect(result, const Left(tCacheFailure));
      // 2. Verify getToken was called
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      // 3. IMPORTANT: Verify the repository was never called
      verifyZeroInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );

  test(
    'should return Failure when the repository fails to update the user',
    () async {
      // Arrange
      // 1. Stub getToken to succeed
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));
      // 2. Stub updateUser to return a failure
      when(() => mockUserRepository.updateUser(any(), any()))
          .thenAnswer((_) async => const Left(tApiFailure));

      // Act
      final result = await usecase(tUserEntityParams);

      // Assert
      // 1. Expect the failure from the repository
      expect(result, const Left(tApiFailure));
      // 2. Verify both dependencies were called with correct data
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockUserRepository.updateUser(tUserEntityParams, tToken)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );
}