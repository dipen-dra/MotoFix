import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/use_case/checkout_user_status_usecase.dart';
import 'package:motofix_app/feature/splash/view_model/spash_view_model.dart';
import 'package:motofix_app/feature/splash/view_model/splash_state.dart';

// --- Mock for the Dependency ---
class MockCheckAuthStatusUseCase extends Mock implements CheckAuthStatusUseCase {}

void main() {
  late SplashCubit splashCubit;
  late MockCheckAuthStatusUseCase mockCheckAuthStatusUseCase;

  setUp(() {
    mockCheckAuthStatusUseCase = MockCheckAuthStatusUseCase();
    splashCubit = SplashCubit(
      checkAuthStatusUseCase: mockCheckAuthStatusUseCase,
    );
  });

  tearDown(() {
    splashCubit.close();
  });

  test('initial state is SplashInitial', () {
    // Assert that the cubit starts in the correct initial state.
    expect(splashCubit.state, isA<SplashInitial>());
  });

  group('checkAuthentication', () {
    blocTest<SplashCubit, SplashState>(
      'emits [SplashAuthenticated] when use case returns a token',
      setUp: () {
        // Arrange: Make the use case succeed with a non-null token string.
        when(() => mockCheckAuthStatusUseCase())
            .thenAnswer((_) async => const Right('fake-auth-token'));
      },
      build: () => splashCubit,
      act: (cubit) => cubit.checkAuthentication(),
      expect: () => [
        // Assert that the correct state type is emitted.
        isA<SplashAuthenticated>(),
      ],
      verify: (_) {
        // Verify that the use case was called.
        verify(() => mockCheckAuthStatusUseCase()).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'emits [SplashUnauthenticated] when use case returns null',
      setUp: () {
        // Arrange: Make the use case succeed but with a null token.
        when(() => mockCheckAuthStatusUseCase())
            .thenAnswer((_) async => const Right(null));
      },
      build: () => splashCubit,
      act: (cubit) => cubit.checkAuthentication(),
      expect: () => [
        isA<SplashUnauthenticated>(),
      ],
      verify: (_) {
        verify(() => mockCheckAuthStatusUseCase()).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'emits [SplashUnauthenticated] when use case returns a failure',
      setUp: () {
        // Arrange: Make the use case fail by returning a Left.
        when(() => mockCheckAuthStatusUseCase()).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'No token found', statusCode: 500)));
      },
      build: () => splashCubit,
      act: (cubit) => cubit.checkAuthentication(),
      expect: () => [
        isA<SplashUnauthenticated>(),
      ],
      verify: (_) {
        verify(() => mockCheckAuthStatusUseCase()).called(1);
      },
    );
  });
}