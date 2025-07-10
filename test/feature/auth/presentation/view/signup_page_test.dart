// test/feature/auth/presentation/view/signup_page_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/feature/auth/presentation/view/signup_page.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/egister_event.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/register_view_model.dart';

// 1. Create the Mock BLoC/ViewModel
class MockRegisterViewModel extends MockBloc<RegisterEvent, RegisterState>
    implements RegisterViewModel {}

// Helper mock for event constructors
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockRegisterViewModel mockRegisterViewModel;

  setUp(() {
    mockRegisterViewModel = MockRegisterViewModel();
    // Register a fallback value for the event, required by mocktail's `verify`
    registerFallbackValue(
      RegisterUserEvent(
        fullName: '',
        email: '',
        password: '',
        context: MockBuildContext(),
      ),
    );
  });

  // Helper function to build the widget tree
  Widget createWidgetUnderTest() {
    return BlocProvider<RegisterViewModel>(
      create: (context) => mockRegisterViewModel,
      child: const MaterialApp(
        home: SignUpPage(),
      ),
    );
  }

  group('SignUpPage', () {
    const validPassword = 'Password123!';

    testWidgets('renders initial UI elements correctly', (tester) async {
      when(() => mockRegisterViewModel.state)
          .thenReturn(RegisterState.initial());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(Checkbox), findsOneWidget);
      // FIX 2: Use the correct case for the button text.
      expect(find.widgetWithText(ElevatedButton, 'SIGN UP'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets(
        'shows validation errors when sign up is tapped with empty fields',
        (tester) async {
      when(() => mockRegisterViewModel.state)
          .thenReturn(RegisterState.initial());
      await tester.pumpWidget(createWidgetUnderTest());

      // Agree to terms to isolate form validation
      await tester.tap(find.byType(Checkbox));
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pump(); // Rebuild with validation messages

      expect(find.text('Please enter your name'), findsOneWidget);
      expect(find.text('Please enter an email'), findsOneWidget);
      expect(find.text('Please enter a password.'), findsOneWidget);
      expect(find.text('Please confirm your password'), findsOneWidget);
    });

    testWidgets('shows snackbar if terms and conditions are not agreed to',
        (tester) async {
      when(() => mockRegisterViewModel.state)
          .thenReturn(RegisterState.initial());
      await tester.pumpWidget(createWidgetUnderTest());

      // Fill the form but DO NOT tap the checkbox
      await tester.enterText(find.byType(TextFormField).at(0), 'Test User');
      await tester.enterText(
          find.byType(TextFormField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), validPassword);
      await tester.enterText(find.byType(TextFormField).at(3), validPassword);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pump(); // To show the snackbar

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Please agree to the terms and conditions.'),
          findsOneWidget);
    });

    testWidgets(
        'adds RegisterUserEvent when form is valid and terms are agreed',
        (tester) async {
      when(() => mockRegisterViewModel.state)
          .thenReturn(RegisterState.initial());
      await tester.pumpWidget(createWidgetUnderTest());

      const name = 'Test User';
      const email = 'test@example.com';

      // Act
      await tester.enterText(find.byType(TextFormField).at(0), name);
      await tester.enterText(find.byType(TextFormField).at(1), email);
      await tester.enterText(find.byType(TextFormField).at(2), validPassword);
      await tester.enterText(find.byType(TextFormField).at(3), validPassword);
      await tester.tap(find.byType(Checkbox));
      // FIX 2: Use the correct case for the button text.
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pump();

      // Assert: Verify the event was added with the correct data
      verify(() => mockRegisterViewModel.add(any(
              that: isA<RegisterUserEvent>()
                  .having((e) => e.fullName, 'fullName', name)
                  .having((e) => e.email, 'email', email)
                  .having((e) => e.password, 'password', validPassword))))
          .called(1);
    });

    testWidgets('shows CircularProgressIndicator when state is loading',
        (tester) async {
      // Assuming RegisterState has `isLoading` and is Equatable.
      whenListen(
        mockRegisterViewModel,
        Stream.fromIterable([
          RegisterState.initial(),
          const RegisterState(isLoading: true),
        ]),
        initialState: RegisterState.initial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Process the new state

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // FIX 2: Use the correct case for the button text.
      final button = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'SIGN UP'));
      expect(button.onPressed, isNull,
          reason: 'Button should be disabled when loading');
    });

    testWidgets('shows terms and conditions dialog when link is tapped',
        (tester) async {
      when(() => mockRegisterViewModel.state)
          .thenReturn(RegisterState.initial());
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Terms and Conditions'));
      await tester.pumpAndSettle(); // Wait for dialog animation

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(
          find.text(
              '1. Acceptance of Terms: By creating an account, you agree to these terms.\n\n'
              '2. Account Responsibilities: You are responsible for your account.\n\n'
              '3. Use of Service: For personal, non-commercial use only.\n\n'
              '4. Privacy Policy: Your use is governed by our Privacy Policy.\n\n'
              '5. Modifications: We can modify these terms at any time.'),
          findsOneWidget);
    });
  });
}
