import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/app/shared_pref/token_shared_prefs.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/use_case/user_logout_usecase.dart';

// Mock from a separate file
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late UserLogoutUseCase usecase;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    usecase = UserLogoutUseCase(tokenSharedPrefs: mockTokenSharedPrefs);
  });

  test(
    'should call clearToken on the TokenSharedPrefs and return success',
    () async {
      // Arrange
      // Stub the clearToken method to return a successful Right(null)
      when(() => mockTokenSharedPrefs.clearToken())
          .thenAnswer((_) async => const Right(null));

      // Act
      // Call the use case
      final result = await usecase();

      // Assert
      // 1. Expect the result to be a Right(null) indicating success
      expect(result, const Right(null));
      // 2. Verify that clearToken was called exactly once
      verify(() => mockTokenSharedPrefs.clearToken()).called(1);
      // 3. Ensure no other methods were called on the mock
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );

  test(
    'should return a Failure when clearToken fails',
    () async {
      // Arrange
      // Define a failure to be returned by the mock
      const cacheFailure = ApiFailure(message: 'Failed to clear token from cache', statusCode: 500);
      
      // Stub the clearToken method to return a Left with the failure
      when(() => mockTokenSharedPrefs.clearToken())
          .thenAnswer((_) async => const Left(cacheFailure));

      // Act
      final result = await usecase();

      // Assert
      // 1. Expect the result to be a Left containing the defined failure
      expect(result, const Left(cacheFailure));
      // 2. Verify that clearToken was still called exactly once
      verify(() => mockTokenSharedPrefs.clearToken()).called(1);
      // 3. Ensure no other interactions occurred
      verifyNoMoreInteractions(mockTokenSharedPrefs);
    },
  );
}