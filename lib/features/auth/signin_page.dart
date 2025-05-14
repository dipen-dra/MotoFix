


// import 'package:flutter/material.dart';
// import 'package:motofix_app/features/auth/forget_password.dart';
// import 'signup_page.dart';// Newly added
// import 'package:url_launcher/url_launcher.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   bool _isPasswordValid = true;
//   bool _obscurePassword = true;

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
//       _isPasswordValid = true;
//     });

//     _showSnackBar("Sign-in successful!", Colors.lightGreenAccent);
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

//   void _launchURL(String urlString) async {
//     final Uri url = Uri.parse(urlString);
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
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

//               // Email Field
//               TextField(
//                 controller: _emailController,
//                 maxLength: 50,
//                 keyboardType: TextInputType.emailAddress,
//                 style: const TextStyle(color: Colors.white),
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
//                   counterText: "",
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Password Field
//               TextField(
//                 controller: _passwordController,
//                 maxLength: 12,
//                 obscureText: _obscurePassword,
//                 style: const TextStyle(color: Colors.white),
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
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: _isPasswordValid ? Colors.white30 : Colors.red,
//                     ),
//                   ),
//                   focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   border: const OutlineInputBorder(),
//                   counterText: "",
//                 ),
//               ),

//               const SizedBox(height: 10),

//               Align(
//                 alignment: Alignment.centerRight,
//                 child: GestureDetector(
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const ForgetPasswordPage()),
//                   ),
//                   child: Text(
//                     "Forget Password?",
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                           color: Colors.white60,
//                           // decoration: TextDecoration.underline,
//                         ),
//                   ),
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
//                     child: const Text(
//                       "Sign up Here",
//                       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                   )
//                 ],
//               ),

//               const SizedBox(height: 40),

//               // Social Links
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () => _launchURL('https://www.instagram.com'),
//                     child: Image.asset(
//                       'assets/insta_logo.png',
//                       height: 40,
//                       width: 40,
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   GestureDetector(
//                     onTap: () => _launchURL('https://www.facebook.com'),
//                     child: Image.asset(
//                       'assets/fb_logo.png',
//                       height: 40,
//                       width: 40,
//                     ),
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



// import 'package:flutter/material.dart';
// import 'package:motofix_app/features/auth/forget_password.dart';
// import 'signup_page.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FocusNode _emailFocusNode = FocusNode();
//   final FocusNode _passwordFocusNode = FocusNode();

//   bool _isPasswordValid = true;
//   bool _obscurePassword = true;

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
//       _isPasswordValid = true;
//     });

//     _showSnackBar("Sign-in successful!", Colors.lightGreenAccent);
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

//   void _launchURL(String urlString) async {
//     final Uri url = Uri.parse(urlString);
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       _showSnackBar("Could not open the URL", Colors.red);
//     }
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _emailFocusNode.dispose();
//     _passwordFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2A4759),
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () {
//             // Unfocus text fields when tapping outside
//             _emailFocusNode.unfocus();
//             _passwordFocusNode.unfocus();
//           },
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 30),
//                 Center(
//                   child: Image.asset(
//                     'assets/motofix_logo.png',
//                     height: 100,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Sign in",
//                   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Please Sign in with your account",
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 const SizedBox(height: 30),

//                 // Email Field with Icon and FocusNode
//                 TextField(
//                   controller: _emailController,
//                   focusNode: _emailFocusNode,
//                   keyboardType: TextInputType.emailAddress,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: const InputDecoration(
//                     labelText: "Email",
//                     labelStyle: TextStyle(color: Colors.white70),
//                     prefixIcon: Icon(Icons.email, color: Colors.white70),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white30),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Password Field with Icon + Toggle Visibility
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: _obscurePassword,
//                   focusNode: _passwordFocusNode,
//                   style: const TextStyle(color: Colors.white),
//                   maxLength: 12,
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                     labelStyle: const TextStyle(color: Colors.white70),
//                     prefixIcon: const Icon(Icons.lock, color: Colors.white70),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                         color: Colors.white70,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: _isPasswordValid ? Colors.white30 : Colors.red),
//                     ),
//                     focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     border: const OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: GestureDetector(
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const ForgetPasswordPage()),
//                     ),
//                     child: const Text(
//                       "Forget Password?",
//                       style: TextStyle(
//                         color: Colors.white,
//                         // fontWeight: FontWeight.bold,
//                         // decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 ElevatedButton(
//                   onPressed: _signIn,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: const Color(0xFF2A4759),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                   child: const Text("SIGN IN", style: TextStyle(fontWeight: FontWeight.bold)),
//                 ),

//                 const SizedBox(height: 20),

//                 const Center(child: Text("Or Sign in with", style: TextStyle(color: Colors.white60))),
//                 const SizedBox(height: 10),

//                 ElevatedButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.facebook),
//                   label: const Text("Sign In with Facebook"),
//                 ),
//                 const SizedBox(height: 10),

//                 ElevatedButton.icon(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     side: const BorderSide(color: Colors.white30),
//                     minimumSize: const Size.fromHeight(50),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   icon: Image.asset(
//                     "assets/image.png",
//                     height: 24,
//                     width: 24,
//                     fit: BoxFit.contain,
//                   ),
//                   label: const Text("Sign In with Google"),
//                 ),

//                 const SizedBox(height: 30),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Don't have an account? ", style: TextStyle(color: Colors.white60)),
//                     GestureDetector(
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const SignUpPage()),
//                       ),
//                       child: const Text("Sign up Here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                     )
//                   ],
//                 ),

//                 const SizedBox(height: 40),

//                 // Instagram and Facebook logos with redirection
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () => _launchURL('https://www.instagram.com'),
//                       child: Image.asset(
//                         'assets/insta_logo.png',
//                         height: 40,
//                         width: 40,
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     GestureDetector(
//                       onTap: () => _launchURL('https://www.facebook.com'),
//                       child: Image.asset(
//                         'assets/fb_logo.png',
//                         height: 40,
//                         width: 40,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:motofix_app/features/auth/forget_password.dart';
// import 'signup_page.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FocusNode _emailFocusNode = FocusNode();
//   final FocusNode _passwordFocusNode = FocusNode();

//   bool _isPasswordValid = true;
//   bool _obscurePassword = true;

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
//       _isPasswordValid = true;
//     });

//     _showSnackBar("Sign-in successful!", Colors.lightGreenAccent);
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

//   void _launchURL(String urlString) async {
//     final Uri url = Uri.parse(urlString);
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       _showSnackBar("Could not open the URL", Colors.red);
//     }
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _emailFocusNode.dispose();
//     _passwordFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2A4759),
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () {
//             // Unfocus text fields when tapping outside
//             _emailFocusNode.unfocus();
//             _passwordFocusNode.unfocus();
//           },
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 30),
//                 Center(
//                   child: Image.asset(
//                     'assets/motofix_logo.png',
//                     height: 100,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Sign in",
//                   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Please Sign in with your account",
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 const SizedBox(height: 30),

//                 // Email Field with Icon and FocusNode
//                 TextField(
//                   controller: _emailController,
//                   focusNode: _emailFocusNode,
//                   keyboardType: TextInputType.emailAddress,
//                   style: const TextStyle(color: Colors.white),
//                   maxLength: 50,  // Character limit
//                   buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,  // Hide counter
//                   decoration: const InputDecoration(
//                     labelText: "Email",
//                     labelStyle: TextStyle(color: Colors.white70),
//                     prefixIcon: Icon(Icons.email, color: Colors.white70),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white30),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Password Field with Icon + Toggle Visibility
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: _obscurePassword,
//                   focusNode: _passwordFocusNode,
//                   style: const TextStyle(color: Colors.white),
//                   maxLength: 12,  // Character limit
//                   buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,  // Hide counter
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                     labelStyle: const TextStyle(color: Colors.white70),
//                     prefixIcon: const Icon(Icons.lock, color: Colors.white70),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                         color: Colors.white70,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: _isPasswordValid ? Colors.white30 : Colors.red),
//                     ),
//                     focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     border: const OutlineInputBorder(),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: GestureDetector(
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const ForgetPasswordPage()),
//                     ),
//                     child: const Text(
//                       "Forget Password?",
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 ElevatedButton(
//                   onPressed: _signIn,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: const Color(0xFF2A4759),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                   child: const Text("SIGN IN", style: TextStyle(fontWeight: FontWeight.bold)),
//                 ),

//                 const SizedBox(height: 20),

//                 const Center(child: Text("Or Sign in with", style: TextStyle(color: Colors.white60))),
//                 const SizedBox(height: 10),

//                 ElevatedButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.facebook),
//                   label: const Text("Sign In with Facebook"),
//                 ),
//                 const SizedBox(height: 10),

//                 ElevatedButton.icon(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     side: const BorderSide(color: Colors.white30),
//                     minimumSize: const Size.fromHeight(50),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   icon: Image.asset(
//                     "assets/image.png",
//                     height: 24,
//                     width: 24,
//                     fit: BoxFit.contain,
//                   ),
//                   label: const Text("Sign In with Google"),
//                 ),

//                 const SizedBox(height: 30),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Don't have an account? ", style: TextStyle(color: Colors.white60)),
//                     GestureDetector(
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const SignUpPage()),
//                       ),
//                       child: const Text("Sign up Here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                     )
//                   ],
//                 ),

//                 const SizedBox(height: 40),

//                 // Instagram and Facebook logos with redirection
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () => _launchURL('https://www.instagram.com'),
//                       child: Image.asset(
//                         'assets/insta_logo.png',
//                         height: 40,
//                         width: 40,
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     GestureDetector(
//                       onTap: () => _launchURL('https://www.facebook.com'),
//                       child: Image.asset(
//                         'assets/fb_logo.png',
//                         height: 40,
//                         width: 40,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:motofix_app/features/auth/forget_password.dart';
import 'signup_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isPasswordValid = true;
  bool _isEmailValid = true;
  bool _obscurePassword = true;

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Please fill in all fields", Colors.red);
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        _isEmailValid = false;
      });
      _showSnackBar("Please enter a valid email address", Colors.red);
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
      _isEmailValid = true;
      _isPasswordValid = true;
    });

    _showSnackBar("Sign-in successful!", Colors.lightGreenAccent);

    _emailController.clear();
    _passwordController.clear();

    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
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

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      _showSnackBar("Could not open the URL", Colors.red);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A4759),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            _emailFocusNode.unfocus();
            _passwordFocusNode.unfocus();
          },
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

                // Email Field
                TextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  maxLength: 50,
                  buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                  onChanged: (value) {
                    setState(() {
                      _isEmailValid = value.isEmpty ? true : _isValidEmail(value.trim());
                    });
                  },
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
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                // Password Field
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  focusNode: _passwordFocusNode,
                  style: const TextStyle(color: Colors.white),
                  maxLength: 12,
                  buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                  onChanged: (value) {
                    setState(() {
                      _isPasswordValid = value.isEmpty ? true : value.length >= 6;
                    });
                  },
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isPasswordValid ? Colors.white30 : Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isPasswordValid ? Colors.white : Colors.red),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgetPasswordPage()),
                    ),
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.white),
                    ),
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

                // Instagram and Facebook logos
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
      ),
    );
  }
}