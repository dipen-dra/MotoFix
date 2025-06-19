// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:motofix_app/feature/auth/domain/use_case/register_use_case.dart';
// import 'package:motofix_app/feature/auth/presentation/view/signin_page.dart';
// import 'package:motofix_app/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/egister_event.dart';
// import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/register_state.dart';

// class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
//   final UserRegisterUseCase _userRegisterUseCase;

//   RegisterViewModel(this._userRegisterUseCase)
//     : super(RegisterState.initial()) {
//     on<RegisterUserEvent>(_onRegisterUser);
//     on<NavigateToLoginEvent>(_onNavigateToLoginEvent);
//   }

//   Future<void> _onRegisterUser(
//     RegisterUserEvent event,
//     Emitter<RegisterState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));

//     await Future.delayed(const Duration(seconds: 1));

//     // Print submitted data
//     print('📝 Submitted Data:');
//     print('name: ${event.name}');
//     print('Email: ${event.email}');
//     print('Password: ${event.password}');
//     print('phone: ${event.phone}');

//     final result = await _userRegisterUseCase(
//       RegisterUserParams(
//         email: event.email,
//         name: event.name,
//         password: event.password,
//         phone: event.phone,
//       ),
//     );

//     result.fold(
//       (l) async {
//         emit(state.copyWith(isLoading: false));

//         if (event.context.mounted) {
//           await showMySnackBar(
//             context: event.context,
//             message: l.message,
//             color: Colors.red,
//           );
//         }
//       },
//       (r) async {
//         emit(state.copyWith(isLoading: false, isSuccess: true));

//         if (event.context.mounted) {
//           Navigator.push(
//             event.context,
//             MaterialPageRoute(
//               builder:
//                   (context) => BlocProvider.value(
//                     value: serviceLocator<LoginViewModel>(),
//                     child: SignInPage(),
//                   ),
//             ),
//           );
//           await showMySnackBar(
//             context: event.context,
//             message: 'Registration successful! Please log in.',
//             color: Colors.green,
//           );
//         }
//       },
//     );
//   }

//   void _onNavigateToLoginEvent(
//     NavigateToLoginEvent event,
//     Emitter<RegisterState> emit,
//   ) {
//     if (event.context.mounted) {
//       Navigator.push(
//         event.context,
//         MaterialPageRoute(
//           builder:
//               (context) => BlocProvider.value(
//                 value: serviceLocator<LoginViewModel>(),
//                 child: SignInPage(),
//               ),
//         ),
//       );
//     }
//   }
// }