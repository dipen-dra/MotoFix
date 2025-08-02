import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/use_case/register_use_case.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/egister_event.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/register_view_model.dart';

// --- Mocks and Fakes for Dependencies ---
class MockUserRegisterUseCase extends Mock implements UserRegisterUseCase {}
class FakeRegisterUserParams extends Fake implements RegisterUserParams {}
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late RegisterViewModel registerViewModel;
  late MockUserRegisterUseCase mockUserRegisterUseCase;

  // --- Test Data ---
  const tFailure = ApiFailure(message: 'Email already exists', statusCode: 409);
  final tRegisterEvent = RegisterUserEvent(
    context: MockBuildContext(),
    fullName: 'Test User',
    password: 'password123',
    email: 'test@test.com',
  );

  setUpAll(() {
    // Required by mocktail for using matchers like `any()` with custom types.
    registerFallbackValue(FakeRegisterUserParams());
  });

  setUp(() {
    mockUserRegisterUseCase = MockUserRegisterUseCase();
    registerViewModel = RegisterViewModel(mockUserRegisterUseCase);
  });

  tearDown(() {
    registerViewModel.close();
  });

  test('initial state is correct', () {
    // Assert that the BLoC starts with the defined initial state.
    expect(registerViewModel.state, const RegisterState.initial());
  });

  group('RegisterUserEvent', () {
    // This test simulates the use case succeeding (returning a Right).
    // According to your ViewModel's logic, a Right from the use case
    // is handled by the second part of your `fold`, which emits `isSuccess: false`.
    blocTest<RegisterViewModel, RegisterState>(
      'emits [loading, isSuccess: false] when use case returns a success (Right)',
      setUp: () {
        // Arrange: Make the use case succeed by returning a Right.
        when(() => mockUserRegisterUseCase(any()))
            .thenAnswer((_) async => const Right(null));
      },
      build: () => registerViewModel,
      act: (bloc) => bloc.add(tRegisterEvent),
      expect: () => <RegisterState>[
        const RegisterState(isLoading: true, isSuccess: false),
        const RegisterState(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        // Verify that the use case was called once.
        verify(() => mockUserRegisterUseCase(any())).called(1);
      },
    );

    // This test simulates the use case failing (returning a Left).
    // According to your ViewModel's logic, a Left from the use case
    // is handled by the first part of your `fold`, which emits `isSuccess: true`.
    blocTest<RegisterViewModel, RegisterState>(
      'emits [loading, isSuccess: true] when use case returns a failure (Left)',
      setUp: () {
        // Arrange: Make the use case fail by returning a Left.
        when(() => mockUserRegisterUseCase(any()))
            .thenAnswer((_) async => const Left(tFailure));
      },
      build: () => registerViewModel,
      act: (bloc) => bloc.add(tRegisterEvent),
      expect: () => <RegisterState>[
        const RegisterState(isLoading: true, isSuccess: false),
        const RegisterState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        // Verify that the use case was called once.
        verify(() => mockUserRegisterUseCase(any())).called(1);
      },
    );
  });
}