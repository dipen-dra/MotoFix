import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/app/shared_pref/token_shared_prefs.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/repository/user_repository.dart';
import 'package:motofix_app/feature/auth/domain/use_case/user_delete_usecase.dart';

// Mocks from separate files
class MockUserRepository extends Mock implements IUserRepository {}
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late UserDeleteUsecase usecase;
  late MockUserRepository mockUserRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    usecase = UserDeleteUsecase(
      iUserRepository: mockUserRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  const tToken = 'sample_auth_token';
  const tApiFailure = ApiFailure(message: 'Failed to delete user', statusCode: 401);
  const tCacheFailure = ApiFailure(message: 'Could not retrieve token', statusCode: 500);

  test(
    'should get token and successfully call repository to delete user',
    () async {
      // Arrange
      // 1. Stub getToken to return a valid token
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));
      // 2. Stub deleteUser to return success (Right<void>)
      when(() => mockUserRepository.deleteUser(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase();

      // Assert
      // 1. Expect a successful result
      expect(result, const Right(null));
      // 2. Verify getToken was called
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      // 3. Verify deleteUser was called with the correct token
      verify(() => mockUserRepository.deleteUser(tToken)).called(1);
      // 4. Ensure no other interactions occurred
      verifyNoMoreInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );

  test(
    'should return a Failure when getting the token fails',
    () async {
      // Arrange
      // 1. Stub getToken to return a failure
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Left(tCacheFailure));

      // Act
      final result = await usecase();

      // Assert
      // 1. Expect the same failure that was returned by getToken
      expect(result, const Left(tCacheFailure));
      // 2. Verify getToken was called
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      // 3. IMPORTANT: Verify that the repository was never called because the process failed early
      verifyZeroInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );

  test(
    'should return a Failure when the repository fails to delete the user',
    () async {
      // Arrange
      // 1. Stub getToken to return a valid token
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));
      // 2. Stub deleteUser to return a failure
      when(() => mockUserRepository.deleteUser(any()))
          .thenAnswer((_) async => const Left(tApiFailure));

      // Act
      final result = await usecase();

      // Assert
      // 1. Expect the failure that was returned by the repository
      expect(result, const Left(tApiFailure));
      // 2. Verify getToken was called
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      // 3. Verify deleteUser was called with the correct token
      verify(() => mockUserRepository.deleteUser(tToken)).called(1);
      // 4. Ensure no other interactions occurred
      verifyNoMoreInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );
}