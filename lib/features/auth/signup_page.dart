

// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:motofix_app/features/auth/custom_textfield.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   String fullPhoneNumber = "";
//   bool _isPhoneValid = true;
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   void _signUp() {
//     final name = _nameController.text.trim();
//     final email = _emailController.text.trim();
//     final password = _passwordController.text;
//     final confirmPassword = _confirmPasswordController.text;

//     if (name.isEmpty || email.isEmpty || fullPhoneNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
//       _showSnackBar("Please fill in all fields", Colors.red);
//       return;
//     }

//     if (password.length < 6) {
//       _showSnackBar("Password should be at least 6 characters", Colors.red);
//       return;
//     }

//     if (password != confirmPassword) {
//       _showSnackBar("Passwords do not match", Colors.red);
//       return;
//     }

//     if (!_isPhoneValid) {
//       _showSnackBar("Please enter a valid phone number", Colors.red);
//       return;
//     }

//     _showSnackBar("Sign-up successful!", Colors.lightGreenAccent);
//   }

//   void _showSnackBar(String message, Color backgroundColor) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: const Duration(seconds: 2),
//         backgroundColor: backgroundColor,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         content: Center(
//           heightFactor: 1,
//           child: Text(
//             message,
//             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2A4759),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 30),
//               Center(
//                 child: Image.asset(
//                   'assets/motofix_logo.png',
//                   height: 90,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               const Text(
//                 "Sign Up",
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               const SizedBox(height: 10),
//               const Text("Create your account", style: TextStyle(color: Colors.white70)),
//               const SizedBox(height: 30),

//               CustomTextField(
//                 controller: _nameController,
//                 label: "Full Name",
//                 prefixIcon: const Icon(Icons.person, color: Colors.white70),
//               ),
//               const SizedBox(height: 20),

//               CustomTextField(
//                 controller: _emailController,
//                 label: "Email",
//                 prefixIcon: const Icon(Icons.email, color: Colors.white70),
//               ),
//               const SizedBox(height: 20),

//               IntlPhoneField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(
//                   labelText: 'Phone Number',
//                   labelStyle: TextStyle(color: Colors.white70),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white30),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   prefixIcon: Icon(Icons.phone, color: Colors.white70),
//                   border: OutlineInputBorder(),
//                 ),
//                 initialCountryCode: 'NP',
//                 style: const TextStyle(color: Colors.white),
//                 dropdownTextStyle: const TextStyle(color: Colors.white),
//                 dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
//                 onChanged: (phone) {
//                   fullPhoneNumber = phone.completeNumber;
//                   setState(() {
//                     _isPhoneValid = phone.number.isNotEmpty && phone.number.length >= 10;
//                   });
//                 },
//               ),

//               const SizedBox(height: 20),

//               CustomTextField(
//                 controller: _passwordController,
//                 label: "Password",
//                 obscureText: _obscurePassword,
//                 prefixIcon: const Icon(Icons.lock, color: Colors.white70),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                     color: Colors.white70,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _obscurePassword = !_obscurePassword;
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),

//               CustomTextField(
//                 controller: _confirmPasswordController,
//                 label: "Confirm Password",
//                 obscureText: _obscureConfirmPassword,
//                 prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//                     color: Colors.white70,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _obscureConfirmPassword = !_obscureConfirmPassword;
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),

//               ElevatedButton(
//                 onPressed: _signUp,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: const Color(0xFF2A4759),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: const Center(
//                   child: Text("SIGN UP", style: TextStyle(fontWeight: FontWeight.bold)),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               const Center(
//                 child: Text("Or Sign Up with", style: TextStyle(color: Colors.white60)),
//               ),
//               const SizedBox(height: 10),

//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.facebook),
//                 label: const Text("Sign Up with Facebook"),
//               ),
//               const SizedBox(height: 10),

//               ElevatedButton.icon(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   side: const BorderSide(color: Colors.white30),
//                   minimumSize: const Size.fromHeight(50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 icon: Image.asset("assets/image.png", height: 24, width: 24, fit: BoxFit.contain),
//                 label: const Text("Sign Up with Google"),
//               ),
//               const SizedBox(height: 30),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Already have an account? ", style: TextStyle(color: Colors.white60)),
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Text("Sign in Here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   String fullPhoneNumber = "";
//   bool _isPhoneValid = true;
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   // Focus nodes
//   final FocusNode _emailFocusNode = FocusNode();
//   final FocusNode _passwordFocusNode = FocusNode();
//   final FocusNode _confirmPasswordFocusNode = FocusNode();

//   void _signUp() {
//     final name = _nameController.text.trim();
//     final email = _emailController.text.trim();
//     final password = _passwordController.text;
//     final confirmPassword = _confirmPasswordController.text;

//     if (name.isEmpty || email.isEmpty || fullPhoneNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
//       _showSnackBar("Please fill in all fields", Colors.red);
//       return;
//     }

//     if (password.length < 6) {
//       _showSnackBar("Password should be at least 6 characters", Colors.red);
//       return;
//     }

//     if (password != confirmPassword) {
//       _showSnackBar("Passwords do not match", Colors.red);
//       return;
//     }

//     if (!_isPhoneValid) {
//       _showSnackBar("Please enter a valid phone number", Colors.red);
//       return;
//     }

//     _showSnackBar("Sign-up successful!", Colors.lightGreenAccent);
//   }

//   void _showSnackBar(String message, Color backgroundColor) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: const Duration(seconds: 2),
//         backgroundColor: backgroundColor,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         content: Center(
//           heightFactor: 1,
//           child: Text(
//             message,
//             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _emailFocusNode.dispose();
//     _passwordFocusNode.dispose();
//     _confirmPasswordFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2A4759),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 30),
//               Center(
//                 child: Image.asset(
//                   'assets/motofix_logo.png',
//                   height: 90,
//                 ),
//               ),
//               const SizedBox(height: 5),
//               const Text(
//                 "Sign Up",
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               const SizedBox(height: 10),
//               const Text("Create your account", style: TextStyle(color: Colors.white70)),
//               const SizedBox(height: 30),

//               // Full Name field
//               TextField(
//                 controller: _nameController,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: const InputDecoration(
//                   labelText: "Full Name",
//                   labelStyle: TextStyle(color: Colors.white70),
//                   prefixIcon: Icon(Icons.person, color: Colors.white70),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white30),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Email field
//               TextField(
//                 controller: _emailController,
//                 focusNode: _emailFocusNode,
//                 keyboardType: TextInputType.emailAddress,
//                 style: const TextStyle(color: Colors.white),
//                 maxLength: 50,  // Character limit
//                 buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,  // Hide counter
//                 decoration: const InputDecoration(
//                   labelText: "Email",
//                   labelStyle: TextStyle(color: Colors.white70),
//                   prefixIcon: Icon(Icons.email, color: Colors.white70),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white30),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Phone number field
//               IntlPhoneField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(
//                   labelText: 'Phone Number',
//                   labelStyle: TextStyle(color: Colors.white70),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white30),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   prefixIcon: Icon(Icons.phone, color: Colors.white70),
//                   border: OutlineInputBorder(),
//                 ),
//                 initialCountryCode: 'NP',
//                 style: const TextStyle(color: Colors.white),
//                 dropdownTextStyle: const TextStyle(color: Colors.white),
//                 dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
//                 onChanged: (phone) {
//                   fullPhoneNumber = phone.completeNumber;
//                   setState(() {
//                     _isPhoneValid = phone.number.isNotEmpty && phone.number.length >= 10;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Password field
//               TextField(
//                 controller: _passwordController,
//                 obscureText: _obscurePassword,
//                 style: const TextStyle(color: Colors.white),
//                 maxLength: 12,  // Character limit
//                 buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,  // Hide counter
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   labelStyle: const TextStyle(color: Colors.white70),
//                   prefixIcon: const Icon(Icons.lock, color: Colors.white70),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                       color: Colors.white70,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       });
//                     },
//                   ),
//                   enabledBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white30),
//                   ),
//                   focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   border: const OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Confirm Password field
//               TextField(
//                 controller: _confirmPasswordController,
//                 obscureText: _obscureConfirmPassword,
//                 style: const TextStyle(color: Colors.white),
//                 maxLength: 12,  // Character limit
//                 buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,  // Hide counter
//                 decoration: InputDecoration(
//                   labelText: "Confirm Password",
//                   labelStyle: const TextStyle(color: Colors.white70),
//                   prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//                       color: Colors.white70,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscureConfirmPassword = !_obscureConfirmPassword;
//                       });
//                     },
//                   ),
//                   enabledBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white30),
//                   ),
//                   focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   border: const OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               ElevatedButton(
//                 onPressed: _signUp,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: const Color(0xFF2A4759),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: const Center(
//                   child: Text("SIGN UP", style: TextStyle(fontWeight: FontWeight.bold)),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               const Center(
//                 child: Text("Or Sign Up with", style: TextStyle(color: Colors.white60)),
//               ),
//               const SizedBox(height: 10),

//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.facebook),
//                 label: const Text("Sign Up with Facebook"),
//               ),
//               const SizedBox(height: 10),

//               ElevatedButton.icon(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   side: const BorderSide(color: Colors.white30),
//                   minimumSize: const Size.fromHeight(50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 icon: Image.asset("assets/image.png", height: 24, width: 24, fit: BoxFit.contain),
//                 label: const Text("Sign Up with Google"),
//               ),
//               const SizedBox(height: 30),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Already have an account? ", style: TextStyle(color: Colors.white60)),
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Text("Sign in Here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String fullPhoneNumber = "";
  bool _isPhoneValid = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Focus nodes
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  void _signUp() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || fullPhoneNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar("Please fill in all fields", Colors.red);
      return;
    }

    if (password.length < 6) {
      _showSnackBar("Password should be at least 6 characters", Colors.red);
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match", Colors.red);
      return;
    }

    if (!_isPhoneValid) {
      _showSnackBar("Please enter a valid phone number", Colors.red);
      return;
    }

    _showSnackBar("Sign-up successful!", Colors.lightGreenAccent);
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Center(
          heightFactor: 1,
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A4759),
      body: GestureDetector(
        onTap: () {
          // Unfocus all fields when tapping outside
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Image.asset(
                    'assets/motofix_logo.png',
                    height: 90,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text("Create your account", style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 30),

                // Full Name field
                TextField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.person, color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Email field
                TextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  maxLength: 50,  // Character limit
                  buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,  // Hide counter
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.email, color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Phone number field
                IntlPhoneField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.phone, color: Colors.white70),
                    border: OutlineInputBorder(),
                  ),
                  initialCountryCode: 'NP',
                  style: const TextStyle(color: Colors.white),
                  dropdownTextStyle: const TextStyle(color: Colors.white),
                  dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  onChanged: (phone) {
                    fullPhoneNumber = phone.completeNumber;
                    setState(() {
                      _isPhoneValid = phone.number.isNotEmpty && phone.number.length >= 10;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Password field
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  maxLength: 12,  // Character limit
                  buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,  // Hide counter
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password field
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  style: const TextStyle(color: Colors.white),
                  maxLength: 12,  // Character limit
                  buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,  // Hide counter
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2A4759),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Center(
                    child: Text("SIGN UP", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),

                const Center(
                  child: Text("Or Sign Up with", style: TextStyle(color: Colors.white60)),
                ),
                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook),
                  label: const Text("Sign Up with Facebook"),
                ),
                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.white30),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: Image.asset("assets/image.png", height: 24, width: 24, fit: BoxFit.contain),
                  label: const Text("Sign Up with Google"),
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ", style: TextStyle(color: Colors.white60)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text("Sign in Here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
