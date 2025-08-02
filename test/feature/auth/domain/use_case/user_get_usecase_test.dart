import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/app/shared_pref/token_shared_prefs.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:motofix_app/feature/auth/domain/repository/user_repository.dart';
import 'package:motofix_app/feature/auth/domain/use_case/user_get_usecase.dart';

// Mocks from separate files
class MockUserRepository extends Mock implements IUserRepository {}
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late UserGetUseCase usecase;
  late MockUserRepository mockUserRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    usecase = UserGetUseCase(
      iUserRepository: mockUserRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  const tToken = 'sample_auth_token';
  const tUserEntity = UserEntity(
    userId: '1',
    fullName: 'Test User',
    email: 'test@example.com',
    password: 'password', // Often the entity from a repo won't include a password
  );
  const tApiFailure = ApiFailure(message: 'Invalid Token', statusCode: 401);
  const tCacheFailure = ApiFailure(message: 'No token found', statusCode: 500);

  test(
    'should get token and then return UserEntity from repository',
    () async {
      // Arrange
      // 1. Stub getToken to return a valid token
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));
      // 2. Stub getUser to return a UserEntity when called with that token
      when(() => mockUserRepository.getUser(any()))
          .thenAnswer((_) async => const Right(tUserEntity));

      // Act
      final result = await usecase();

      // Assert
      // 1. Expect the result to be the user entity
      expect(result, const Right(tUserEntity));
      // 2. Verify that getToken was called
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      // 3. Verify that getUser was called with the correct token
      verify(() => mockUserRepository.getUser(tToken)).called(1);
      // 4. Ensure no other interactions occurred
      verifyNoMoreInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );

  test(
    'should return Failure when getToken fails',
    () async {
      // Arrange
      // 1. Stub getToken to return a failure
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Left(tCacheFailure));

      // Act
      final result = await usecase();

      // Assert
      // 1. Expect the result to be the failure from shared prefs
      expect(result, const Left(tCacheFailure));
      // 2. Verify that getToken was called
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      // 3. IMPORTANT: Verify the repository was never called
      verifyZeroInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );

  test(
    'should return Failure when repository getUser fails',
    () async {
      // Arrange
      // 1. Stub getToken to succeed
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));
      // 2. Stub getUser to return a failure
      when(() => mockUserRepository.getUser(any()))
          .thenAnswer((_) async => const Left(tApiFailure));

      // Act
      final result = await usecase();

      // Assert
      // 1. Expect the result to be the failure from the repository
      expect(result, const Left(tApiFailure));
      // 2. Verify both dependencies were called in order
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verify(() => mockUserRepository.getUser(tToken)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );
  
  test(
    'should call repository with null when token from shared prefs is null',
    () async {
      // Arrange
      // 1. Stub getToken to return Right(null)
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(null));
      // 2. Stub the repository to handle the null token case
      when(() => mockUserRepository.getUser(null))
          .thenAnswer((_) async => const Right(tUserEntity));

      // Act
      final result = await usecase();

      // Assert
      expect(result, const Right(tUserEntity));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      // 3. Verify that getUser was called specifically with null
      verify(() => mockUserRepository.getUser(null)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );
}