import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart'; // <-- IMPORT THIS PACKAGE
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/use_case/login_use_case.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';

// --- Mocks and Fakes ---
class MockUserLoginUseCase extends Mock implements UserLoginUseCase {}
class FakeLoginParams extends Fake implements LoginParams {}
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late LoginViewModel loginViewModel;
  late MockUserLoginUseCase mockUserLoginUseCase;

  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
  });

  setUp(() {
    mockUserLoginUseCase = MockUserLoginUseCase();
    loginViewModel = LoginViewModel(mockUserLoginUseCase);
  });

  tearDown(() {
    loginViewModel.close();
  });

  test('initial state has isLoading: false and isSuccess: false', () {
    expect(loginViewModel.state.isLoading, isFalse);
    expect(loginViewModel.state.isSuccess, isFalse);
  });

  group('LoginWithEmailAndPassword', () {
    final loginEvent = LoginWithEmailAndPassword(
      context: MockBuildContext(),
      email: 'test@test.com',
      password: 'password',
    );

    // =======================================================================
    // THIS IS THE MANUAL TEST FOR THE SUCCESS CASE. IT WILL NOT HANG.
    // =======================================================================
    test(
      'emits correct loading and success states when login succeeds',
      () {
        // We wrap the entire test in `fakeAsync` to gain control over time.
        fakeAsync((async) {
          // Arrange
          final states = <LoginState>[];
          final subscription = loginViewModel.stream.listen(states.add);

          when(() => mockUserLoginUseCase(any()))
              .thenAnswer((_) async => const Right('fake-token'));

          // Act
          loginViewModel.add(loginEvent);

          // Flush all microtasks to process the `await` on the use case call.
          // This runs all the code up until the Future.delayed.
          async.flushMicrotasks();

          // Assert (Part 1)
          // Check the states that were emitted *before* the timer.
          expect(states.length, 2);
          expect(states[0].isLoading, true);
          expect(states[0].isSuccess, false);
          expect(states[1].isLoading, false);
          expect(states[1].isSuccess, true);

          // Now, let's fast-forward the clock to trigger the Future.delayed
          async.elapse(const Duration(milliseconds: 600));

          // Assert (Part 2)
          // Verify the use case was called.
          verify(() => mockUserLoginUseCase(any())).called(1);
          // Ensure no *new* states were emitted after the delay.
          expect(states.length, 2);

          // Cleanup
          subscription.cancel();
        });
      },
    );

    // =======================================================================
    // The failure test is simple and has no timers, so blocTest is still fine.
    // =======================================================================
    blocTest<LoginViewModel, LoginState>(
      'emits correct loading and failure states when login fails',
      setUp: () {
        when(() => mockUserLoginUseCase(any())).thenAnswer(
            (_) async => const Left(ApiFailure(message: 'Error', statusCode: 401)));
      },
      build: () => loginViewModel,
      act: (bloc) => bloc.add(loginEvent),
      expect: () => [
        // Using `isA<LoginState>()` is a robust way to check without Equatable
        isA<LoginState>()
            .having((s) => s.isLoading, 'isLoading', true)
            .having((s) => s.isSuccess, 'isSuccess', false),
        isA<LoginState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.isSuccess, 'isSuccess', false),
      ],
      verify: (_) {
        verify(() => mockUserLoginUseCase(any())).called(1);
      },
    );
  });
}