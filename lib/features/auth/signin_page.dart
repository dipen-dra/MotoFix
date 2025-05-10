// import 'package:flutter/material.dart';
// import 'package:motofix_app/features/auth/custom_textfield.dart';
// import 'signup_page.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _signIn() {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text;

//     if (email.isEmpty || password.isEmpty) {
//       _showSnackBar("Please fill in all fields", Colors.red);
//       return;
//     }
//     _showSnackBar("Sign-in successful!", Colors.lightGreenAccent);
//     // TODO: Implement actual sign-in logic
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
//     _emailController.dispose();
//     _passwordController.dispose();
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
//                   height: 100,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Sign in",
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Please Sign in with your account",
//                 style: TextStyle(color: Colors.white70),
//               ),
//               const SizedBox(height: 30),
//               CustomTextField(controller: _emailController, label: "Email"),
//               const SizedBox(height: 20),
//               CustomTextField(controller: _passwordController, label: "Password", obscureText: true),
//               const SizedBox(height: 10),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   "Forget Password?",
//                   style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _signIn,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: const Color(0xFF2A4759),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: const Text("SIGN IN", style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//               const SizedBox(height: 20),
//               const Center(child: Text("Or Sign in with", style: TextStyle(color: Colors.white60))),
//               const SizedBox(height: 10),
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.facebook),
//                 label: const Text("Sign In with Facebook"),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   side: const BorderSide(color: Colors.white30),
//                   minimumSize: const Size.fromHeight(50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 icon: Image.asset(
//                   "assets/image.png",
//                   height: 24,
//                   width: 24,
//                   fit: BoxFit.contain,
//                 ),
//                 label: const Text("Sign In with Google"),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account? ", style: TextStyle(color: Colors.white60)),
//                   GestureDetector(
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const SignUpPage()),
//                     ),
//                     child: const Text("Sign up Here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                   )
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
// import 'package:motofix_app/features/auth/custom_textfield.dart';
// import 'signup_page.dart';
// import 'package:url_launcher/url_launcher.dart'; // For URL redirection

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   bool _isPasswordValid = true; // Flag for password validation

//   void _signIn() {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text;

//     if (email.isEmpty || password.isEmpty) {
//       _showSnackBar("Please fill in all fields", Colors.red);
//       return;
//     }

//     if (password.length < 6) {
//       setState(() {
//         _isPasswordValid = false;
//       });
//       _showSnackBar("Password should be at least 6 characters", Colors.red);
//       return;
//     }

//     setState(() {
//       _isPasswordValid = true; // Reset validation flag if password is correct
//     });

//     _showSnackBar("Sign-in successful!", Colors.lightGreenAccent);
//     // TODO: Implement actual sign-in logic
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

//   // Method to launch URL
//   void _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       _showSnackBar("Could not open the URL", Colors.red);
//     }
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
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
//                   height: 100,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Sign in",
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Please Sign in with your account",
//                 style: TextStyle(color: Colors.white70),
//               ),
//               const SizedBox(height: 30),
//               CustomTextField(controller: _emailController, label: "Email"),
//               const SizedBox(height: 20),
//               // Password Field with Validation
//               TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   labelStyle: const TextStyle(color: Colors.white70),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: _isPasswordValid ? Colors.white30 : Colors.red),
//                   ),
//                   focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   border: const OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   "Forget Password?",
//                   style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _signIn,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: const Color(0xFF2A4759),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: const Text("SIGN IN", style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//               const SizedBox(height: 20),
//               const Center(child: Text("Or Sign in with", style: TextStyle(color: Colors.white60))),
//               const SizedBox(height: 10),
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: const Icon(Icons.facebook),
//                 label: const Text("Sign In with Facebook"),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   side: const BorderSide(color: Colors.white30),
//                   minimumSize: const Size.fromHeight(50),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 icon: Image.asset(
//                   "assets/image.png",
//                   height: 24,
//                   width: 24,
//                   fit: BoxFit.contain,
//                 ),
//                 label: const Text("Sign In with Google"),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account? ", style: TextStyle(color: Colors.white60)),
//                   GestureDetector(
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const SignUpPage()),
//                     ),
//                     child: const Text("Sign up Here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Instagram and Facebook icons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.camera_alt, color: Colors.white),
//                     onPressed: () => _launchURL('https://www.instagram.com'),
//                   ),
//                   const SizedBox(width: 20),
//                   IconButton(
//                     icon: const Icon(Icons.facebook, color: Colors.white),
//                     onPressed: () => _launchURL('https://www.facebook.com'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:motofix_app/features/auth/custom_textfield.dart';
import 'signup_page.dart';
import 'package:url_launcher/url_launcher.dart'; // For URL redirection

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordValid = true; // Flag for password validation

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Please fill in all fields", Colors.red);
      return;
    }

    if (password.length < 6) {
      setState(() {
        _isPasswordValid = false;
      });
      _showSnackBar("Password should be at least 6 characters", Colors.red);
      return;
    }

    setState(() {
      _isPasswordValid = true; // Reset validation flag if password is correct
    });

    _showSnackBar("Sign-in successful!", Colors.lightGreenAccent);
    // TODO: Implement actual sign-in logic
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

  // Method to launch URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showSnackBar("Could not open the URL", Colors.red);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A4759),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/motofix_logo.png',
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Sign in",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please Sign in with your account",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 30),
              CustomTextField(controller: _emailController, label: "Email"),
              const SizedBox(height: 20),
              // Password Field with Validation
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _isPasswordValid ? Colors.white30 : Colors.red),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forget Password?",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2A4759),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("SIGN IN", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              const Center(child: Text("Or Sign in with", style: TextStyle(color: Colors.white60))),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.facebook),
                label: const Text("Sign In with Facebook"),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.white30),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: Image.asset(
                  "assets/image.png",
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
                ),
                label: const Text("Sign In with Google"),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Colors.white60)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    ),
                    child: const Text("Sign up Here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  )
                ],
              ),
              const SizedBox(height: 40),

              // Instagram and Facebook logos with redirection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _launchURL('https://www.instagram.com'),
                    child: Image.asset(
                      'assets/insta_logo.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => _launchURL('https://www.facebook.com'),
                    child: Image.asset(
                      'assets/fb_logo.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
