// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final bool obscureText;
//   final bool showError;

//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.label,
//     this.obscureText = false,
//     this.showError = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.white70),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: showError ? Colors.red : Colors.white30),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: showError ? Colors.red : Colors.white),
//         ),
//         border: const OutlineInputBorder(),
//       ),
//       style: const TextStyle(color: Colors.white),
//     );
//   }
// }


// custom_textfield.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
