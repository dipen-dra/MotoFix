import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/app/shared_pref/token_shared_prefs.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/use_case/checkout_user_status_usecase.dart';

// A mock class for TokenSharedPrefs
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late CheckAuthStatusUseCase usecase;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    usecase = CheckAuthStatusUseCase(tokenSharedPrefs: mockTokenSharedPrefs);
  });

  const tToken = 'sample_token';

  test(
    'should get token from the shared preferences',
    () async {
      // Arrange
      // Stub the getToken method to return a Right with a token
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(tToken));

      // Act
      // Call the use case
      final result = await usecase();

      // Assert
      // Expect the result to be a Right containing the token
      expect(result, const Right(tToken));
      // Verify that getToken was called exactly once
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      // Verify that no other interactions happened with the mock
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );

  test(
    'should return null when there is no token in shared preferences',
    () async {
      // Arrange
      // Stub the getToken method to return a Right with null
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase();

      // Assert
      // Expect the result to be a Right containing null
      expect(result, const Right(null));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );

  test(
    'should return a Failure when getting token from shared preferences fails',
    () async {
      // Arrange
      // Stub the getToken method to return a Left with a CacheFailure
      const cacheFailure = ApiFailure(message: 'Failed to retrieve token', statusCode: 500);
      when(() => mockTokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Left(cacheFailure));

      // Act
      final result = await usecase();

      // Assert
      // Expect the result to be a Left containing the failure
      expect(result, const Left(cacheFailure));
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );
}