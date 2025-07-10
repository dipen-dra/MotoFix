import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/use_case/login_use_case.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';

class MockUserLoginUseCase extends Mock implements UserLoginUseCase {}

class MockBuildContext extends Mock implements BuildContext {}

// Custom matcher for LoginState
Matcher isLoginState({
  required bool isLoading,
  required bool isSuccess,
  String? errorMessage,
}) {
  return predicate<LoginState>((state) {
    return state.isLoading == isLoading && state.isSuccess == isSuccess;
  });
}

void main() {
  late UserLoginUseCase mockUserLoginUseCase;
  late LoginViewModel loginViewModel;
  late BuildContext mockContext;

  setUp(() {
    mockUserLoginUseCase = MockUserLoginUseCase();
    mockContext = MockBuildContext();
    when(() => mockContext.mounted).thenReturn(true);
    registerFallbackValue(const LoginParams(email: '', password: ''));
    registerFallbackValue(mockContext);
  });

  tearDown(() {
    loginViewModel.close();
  });

  group('LoginViewModel', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    test('initial state is correct', () {
      // Initialize the view model here for this specific test
      loginViewModel = LoginViewModel(mockUserLoginUseCase);

      expect(loginViewModel.state,
          isLoginState(isLoading: false, isSuccess: false));
    });

    blocTest<LoginViewModel, LoginState>(
      'emits [loading, success] when LoginWithEmailAndPassword is added and use case succeeds.',
      build: () {
        // Mock the use case to return success
        when(() => mockUserLoginUseCase.call(any()))
            .thenAnswer((_) async => const Right(tEmail));

        // Return a fresh instance of LoginViewModel
        return LoginViewModel(mockUserLoginUseCase);
      },
      act: (bloc) => bloc.add(
        LoginWithEmailAndPassword(
          context: mockContext,
          email: tEmail,
          password: tPassword,
        ),
      ),
      expect: () => [
        isLoginState(isLoading: true, isSuccess: false),
        isLoginState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockUserLoginUseCase.call(
              const LoginParams(email: tEmail, password: tPassword),
            )).called(1);
        verifyNoMoreInteractions(mockUserLoginUseCase);
      },
    );

    blocTest<LoginViewModel, LoginState>(
      'emits [loading, failure] when LoginWithEmailAndPassword is added and use case fails.',
      build: () {
        // Mock the use case to return failure
        when(() => mockUserLoginUseCase.call(any())).thenAnswer((_) async =>
            Left(ApiFailure(message: 'Invalid credentials', statusCode: 401)));

        // Return a fresh instance of LoginViewModel
        return LoginViewModel(mockUserLoginUseCase);
      },
      act: (bloc) => bloc.add(
        LoginWithEmailAndPassword(
          context: mockContext,
          email: tEmail,
          password: 'wrong_password',
        ),
      ),
      expect: () => [
        isLoginState(isLoading: true, isSuccess: false),
        isLoginState(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockUserLoginUseCase.call(
              const LoginParams(email: tEmail, password: 'wrong_password'),
            )).called(1);
        verifyNoMoreInteractions(mockUserLoginUseCase);
      },
    );

    blocTest<LoginViewModel, LoginState>(
      'handles NavigateToRegisterView event without state change',
      build: () => LoginViewModel(mockUserLoginUseCase),
      act: (bloc) => bloc.add(
        NavigateToRegisterView(context: mockContext),
      ),
      expect: () => <LoginState>[],
      verify: (_) {
        verify(() => mockContext.mounted).called(1);
      },
    );
  });
}
