// import 'package:flutter/material.dart';

// class ForgetPasswordPage extends StatefulWidget {
//   const ForgetPasswordPage({super.key});

//   @override
//   State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
// }

// class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
//   final TextEditingController _emailController = TextEditingController();
//   bool _emailSent = false;

//   void _resetPassword() {
//     final email = _emailController.text.trim();

//     if (email.isEmpty) {
//       _showSnackBar("Please enter your email", Colors.red);
//       return;
//     }

//     setState(() {
//       _emailSent = true;
//     });

//     _showSnackBar("Password reset link sent to $email", Colors.green);

//   }

//   void _showSnackBar(String message, Color color) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2A4759),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2A4759),
//         title: const Text("Reset Password", style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Forgot your password?",
//               style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Enter your registered email address. We'll send you a link to reset your password.",
//               style: TextStyle(color: Colors.white70),
//             ),
//             const SizedBox(height: 30),
//             TextField(
//               controller: _emailController,
//               style: const TextStyle(color: Colors.white),
//               keyboardType: TextInputType.emailAddress,
//               decoration: const InputDecoration(
//                 labelText: "Email",
//                 labelStyle: TextStyle(color: Colors.white70),
//                 prefixIcon: Icon(Icons.email, color: Colors.white70),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white30),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: _resetPassword,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: const Color(0xFF2A4759),
//                 minimumSize: const Size.fromHeight(50),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               child: const Text("SEND RESET LINK", style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             const SizedBox(height: 20),
//             if (_emailSent)
//               const Text(
//                 "Check your inbox for the reset link.",
//                 style: TextStyle(color: Colors.lightGreenAccent),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class ForgetPasswordPage extends StatefulWidget {
//   const ForgetPasswordPage({super.key});

//   @override
//   State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
// }

// class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _emailSent = false;

//   // Email validation using regex
//   bool _isValidEmail(String email) {
//     return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
//   }

//   void _resetPassword() {
//     if (_formKey.currentState?.validate() ?? false) {
//       final email = _emailController.text.trim();

//       setState(() {
//         _emailSent = true;
//       });

//       _showSnackBar("Password reset link sent to $email", Colors.green);
//     }
//   }

//   void _showSnackBar(String message, Color color) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2A4759),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2A4759),
//         title: const Text("Reset Password", style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Forgot your password?",
//                 style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Enter your registered email address. We'll send you a link to reset your password.",
//                 style: TextStyle(color: Colors.white70),
//               ),
//               const SizedBox(height: 30),
//               TextFormField(
//                 controller: _emailController,
//                 style: const TextStyle(color: Colors.white),
//                 keyboardType: TextInputType.emailAddress,
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
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!_isValidEmail(value)) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _resetPassword,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: const Color(0xFF2A4759),
//                   minimumSize: const Size.fromHeight(50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: const Text("SEND RESET LINK", style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//               const SizedBox(height: 20),
//               if (_emailSent)
//                 const Text(
//                   "Check your inbox for the reset link.",
//                   style: TextStyle(color: Colors.lightGreenAccent),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _emailSent = false;
  bool _isEmailValid = true; // To track email validity

  // Email validation using regex
  bool _isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

  void _resetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();

      setState(() {
        _emailSent = true;
        _isEmailValid = true; // Reset email validity on success
      });

      _showSnackBar("Password reset link sent to $email", Colors.green);

      // Show the "Check your inbox" message for 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _emailSent = false;
        });
      });
    } else {
      setState(() {
        _isEmailValid = false; // Set email as invalid when validation fails
      });
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A4759),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A4759),
        title: const Text("Reset Password", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Forgot your password?",
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your registered email address. We'll send you a link to reset your password.",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.email, color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _isEmailValid ? Colors.white30 : Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _isEmailValid ? Colors.white : Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!_isValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2A4759),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("SEND RESET LINK", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              if (_emailSent)
                Center(
                  child: const Text(
                    "Check your inbox for the reset link.",
                    style: TextStyle(color:Colors.white,)
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

