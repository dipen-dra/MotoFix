import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:motofix_app/feature/auth/domain/use_case/user_delete_usecase.dart';
import 'package:motofix_app/feature/auth/domain/use_case/user_get_usecase.dart';
import 'package:motofix_app/feature/auth/domain/use_case/user_logout_usecase.dart';
import 'package:motofix_app/feature/auth/domain/use_case/user_update_usecase.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/profile_view_model/profile_event.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/profile_view_model/profile_view_model.dart';

// --- Mocks for all dependencies ---
class MockUserGetUseCase extends Mock implements UserGetUseCase {}
class MockUserUpdateUsecase extends Mock implements UserUpdateUsecase {}
class MockUserDeleteUsecase extends Mock implements UserDeleteUsecase {}
class MockUserLogoutUseCase extends Mock implements UserLogoutUseCase {}
class FakeUserEntity extends Fake implements UserEntity {}

void main() {
  late ProfileViewModel profileViewModel;
  late MockUserGetUseCase mockUserGetUseCase;
  late MockUserUpdateUsecase mockUserUpdateUsecase;
  late MockUserDeleteUsecase mockUserDeleteUsecase;
  late MockUserLogoutUseCase mockUserLogoutUseCase;

  // --- Test Data ---
  const tUserEntity = UserEntity(
    userId: '1',
    fullName: 'Test User',
    email: 'test@test.com',
    password: 'password',
  );
  const tFailure = ApiFailure(message: 'Server Error', statusCode: 500);

  setUpAll(() {
    // Required for mocktail when a mock's method takes a custom object
    registerFallbackValue(FakeUserEntity());
  });

  setUp(() {
    mockUserGetUseCase = MockUserGetUseCase();
    mockUserUpdateUsecase = MockUserUpdateUsecase();
    mockUserDeleteUsecase = MockUserDeleteUsecase();
    mockUserLogoutUseCase = MockUserLogoutUseCase();
  });

  // A helper function to create the ViewModel and stub the initial load
  void setupViewModelWithSuccessfulInitialLoad() {
    when(() => mockUserGetUseCase())
        .thenAnswer((_) async => const Right(tUserEntity));

    profileViewModel = ProfileViewModel(
      userGetUseCase: mockUserGetUseCase,
      userUpdateUseCase: mockUserUpdateUsecase,
      userDeleteUsecase: mockUserDeleteUsecase,
      userLogoutUseCase: mockUserLogoutUseCase,
    );
  }

  // --- Tests Start Here ---

  test('initial state is correct', () {
    // Since the constructor triggers an event, we test the state
    // right after initialization but before the event completes.
    // The initial load is stubbed to prevent errors.
    setupViewModelWithSuccessfulInitialLoad();
    expect(profileViewModel.state, ProfileState.initial());
  });

  group('LoadProfileEvent', () {
    // This tests the automatic event dispatch from the constructor
    blocTest<ProfileViewModel, ProfileState>(
      'emits [loading, success] when data is fetched successfully',
      setUp: () {
        when(() => mockUserGetUseCase())
            .thenAnswer((_) async => const Right(tUserEntity));
      },
      build: () => ProfileViewModel(
        userGetUseCase: mockUserGetUseCase,
        userUpdateUseCase: mockUserUpdateUsecase,
        userDeleteUsecase: mockUserDeleteUsecase,
        userLogoutUseCase: mockUserLogoutUseCase,
      ),
      expect: () => <ProfileState>[
        ProfileState.initial().copyWith(isLoading: true),
        ProfileState.initial().copyWith(
          isLoading: false,
          userEntity: tUserEntity,
          isEditing: false,
        ),
      ],
      verify: (_) {
        verify(() => mockUserGetUseCase()).called(1);
      },
    );

    blocTest<ProfileViewModel, ProfileState>(
      'emits [loading, failure] when data fetching fails',
      setUp: () {
        when(() => mockUserGetUseCase())
            .thenAnswer((_) async => const Left(tFailure));
      },
      build: () => ProfileViewModel(
        userGetUseCase: mockUserGetUseCase,
        userUpdateUseCase: mockUserUpdateUsecase,
        userDeleteUsecase: mockUserDeleteUsecase,
        userLogoutUseCase: mockUserLogoutUseCase,
      ),
      expect: () => <ProfileState>[
        ProfileState.initial().copyWith(isLoading: true),
        ProfileState.initial().copyWith(
          isLoading: false,
          onError: tFailure.message,
        ),
      ],
    );
  });

  group('ToggleEditModeEvent', () {
    setUp(() => setupViewModelWithSuccessfulInitialLoad());

    blocTest<ProfileViewModel, ProfileState>(
      'emits state with isEditing: true when toggled from false',
      build: () => profileViewModel,
      seed: () => ProfileState.initial().copyWith(isEditing: false),
      act: (bloc) => bloc.add(ToggleEditModeEvent()),
      expect: () => <ProfileState>[
        ProfileState.initial().copyWith(isEditing: true),
      ],
    );
  });



  group('DeleteProfileEvent', () {
    setUp(() => setupViewModelWithSuccessfulInitialLoad());

    blocTest<ProfileViewModel, ProfileState>(
      'emits [loading, success] when profile deletion is successful',
      setUp: () {
        when(() => mockUserDeleteUsecase())
            .thenAnswer((_) async => const Right(null));
      },
      build: () => profileViewModel,
      act: (bloc) => bloc.add(DeleteProfileEvent()),
      expect: () => <ProfileState>[
        profileViewModel.state.copyWith(isLoading: true),
        profileViewModel.state.copyWith(
          isLoading: false,
          isProfileDeleted: true,
          userEntity: null,
        ),
      ],
      verify: (_) {
        verify(() => mockUserDeleteUsecase()).called(1);
      },
    );
  });
}