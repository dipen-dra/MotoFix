import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart'; // <-- IMPORT
import 'package:motofix_app/feature/auth/domain/entity/auth_entity.dart';
import 'package:motofix_app/feature/auth/presentation/view/profile_screen.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/profile_view_model/profile_event.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/profile_view_model/profile_view_model.dart';
import 'package:network_image_mock/network_image_mock.dart';

// --- Mocks and Fakes ---
class MockProfileViewModel extends MockBloc<ProfileEvent, ProfileState> implements ProfileViewModel {}
class FakeProfileState extends Fake implements ProfileState {}

void main() {
  late MockProfileViewModel mockProfileViewModel;

  const tUserEntity = UserEntity(
    userId: '1',
    fullName: 'Lionel Messi',
    email: 'leo@goat.com',
    phone: '1234567890',
    address: 'Paris, France',
    password: '',
  );

  setUpAll(() {
    registerFallbackValue(FakeProfileState());
  });

  setUp(() {
    mockProfileViewModel = MockProfileViewModel();
  });

  // Helper function remains simple.
  Future<void> pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockProfileViewModel,
          child: const ProfileViewPage(),
        ),
      ),
    );
  }

  group('ProfileViewPage', () {
    // Wrap each testWidgets call
    testWidgets('shows loading indicator when initially loading profile', (tester) async {
      mockNetworkImagesFor(() async {
        when(() => mockProfileViewModel.state).thenReturn(
          ProfileState.initial().copyWith(isLoading: true, userEntity: null),
        );
        await pumpWidget(tester);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    testWidgets('displays user data in View Mode when loaded', (tester) async {
      mockNetworkImagesFor(() async {
        when(() => mockProfileViewModel.state).thenReturn(
          ProfileState.initial().copyWith(isLoading: false, userEntity: tUserEntity, isEditing: false),
        );
        await pumpWidget(tester);
        await tester.pumpAndSettle();

        expect(find.text(tUserEntity.fullName), findsNWidgets(2));
        expect(find.text(tUserEntity.email), findsNWidgets(2));
        expect(find.text(tUserEntity.phone!), findsOneWidget);
        expect(find.text(tUserEntity.address!), findsOneWidget);
        expect(find.byType(TextFormField), findsNothing);
        expect(find.text('Edit Profile'), findsOneWidget);
      });
    });

    testWidgets('adds ToggleEditModeEvent when "Edit Profile" button is tapped', (tester) async {
      mockNetworkImagesFor(() async {
        when(() => mockProfileViewModel.state).thenReturn(
          ProfileState.initial().copyWith(isLoading: false, userEntity: tUserEntity, isEditing: false),
        );
        await pumpWidget(tester);
        await tester.tap(find.text('Edit Profile'));
        await tester.pump();
        verify(() => mockProfileViewModel.add(ToggleEditModeEvent())).called(1);
      });
    });
  });
}