import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motofix_app/features/auth/signin_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _progressAnimation; // Added for progress indication
  double _progressValue = 0.0;

  // Define our theme colors
  final Color _primaryColor = const Color(0xFF2A4759);
  final Color _complementaryColor = const Color(0xFFB08A67);
  final Color _accentColor = const Color(0xFFE8C19A);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4), // Increased duration to 10 seconds
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate( // Animate from 0 to 1
      CurvedAnimation(parent: _controller, curve: Curves.linear), // Use linear curve
    );

    _progressAnimation.addListener(() { // Listen to animation changes
      setState(() {
        _progressValue = _progressAnimation.value; // Update value
      });
    });

    _controller.forward();

    Timer(const Duration(seconds: 4), () { // Match the timer with the animation duration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignInPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: _primaryColor, // Primary color for background
        ),
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/motofix_logo.png',
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, color: Colors.redAccent, size: 60),
                ),
                const SizedBox(height: 40),
                // Use a LinearProgressIndicator for a progress bar
                SizedBox(
                  width: 200, // Set a fixed width for the progress bar
                  child: LinearProgressIndicator(
                    value: _progressValue, // Bind the animation value
                    backgroundColor: _complementaryColor.withOpacity(0.3), // Lighter complementary color for the background
                    valueColor: AlwaysStoppedAnimation<Color>(_accentColor), // Accent color for the progress bar
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "MotoFix",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your trusted partner for 2-wheeler vehicle care",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:motofix_app/features/auth/signin_page.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );

//     _controller.forward();

//     Timer(const Duration(seconds: 4), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const SignInPage()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/motofix.png',
//                 height: 150,
//                 fit: BoxFit.contain,
//                 errorBuilder: (context, error, stackTrace) =>
//                     const Icon(Icons.error, color: Colors.red, size: 48),
//               ),
//               const SizedBox(height: 40),
//               const CircularProgressIndicator(
//                 color: Color(0xFFF79B72), // Accent color
//               ),
//               const SizedBox(height: 30),
//               const Text(
//                 "Welcome to MotoFix",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Get your vehicle serviced\nanytime, anywhere",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:motofix_app/features/auth/signin_page.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   // Define our theme colors
//   final Color _primaryColor = const Color(0xFF2A4759);        // Deep blue-grey
//   final Color _complementaryColor = const Color(0xFFB08A67);  // Muted orange-brown
//   final Color _accentColor = const Color(0xFFE8C19A);      // Light orange-brown

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//     _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
//     );

//     _controller.forward();

//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const SignInPage()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [
//               _primaryColor, // Use the primary color for the darker end
//               _complementaryColor, // Use the complementary color
//             ],
//           ),
//         ),
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/motofix.png',
//                     height: 180,
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) =>
//                         const Icon(Icons.error, color: Colors.redAccent, size: 60),
//                   ),
//                   const SizedBox(height: 50),
//                   CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(_accentColor), // Use the accent color for contrast
//                   ),
//                   const SizedBox(height: 40),
//                   const Text(
//                     "MOTOFIX",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 30,
//                       fontWeight: FontWeight.w900,
//                       letterSpacing: 2.0,
//                       shadows: [
//                         Shadow(
//                           blurRadius: 5.0,
//                           color: Colors.black87,
//                           offset: Offset(2.0, 2.0),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   const Text(
//                     "Your trusted partner for vehicle care",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16,
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:motofix_app/features/auth/signin_page.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _opacityAnimation;

//   // Define our theme colors
//   final Color _primaryColor = const Color(0xFF2A4759);
//   final Color _complementaryColor = const Color(0xFFB08A67);
//   final Color _accentColor = const Color(0xFFE8C19A);

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1500), // Shorter duration
//       vsync: this,
//     );

//     _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate( // Simple opacity animation
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut), // Use easeOut
//     );

//     _controller.forward();

//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const SignInPage()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           color: _primaryColor, // Use solid primary color for background
//         ),
//         child: FadeTransition(
//           opacity: _opacityAnimation,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/motofix.png',
//                   height: 150, // Smaller logo
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.error, color: Colors.redAccent, size: 60),
//                 ),
//                 const SizedBox(height: 40),
//                 CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(_accentColor),
//                   strokeWidth: 3,
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   "MOTOFIX",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28, // Slightly smaller title
//                     fontWeight: FontWeight.w700, // Use w700 for a slightly lighter bold
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Your trusted partner for vehicle care",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//best
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:motofix_app/features/auth/signin_page.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _opacityAnimation;
//   late Animation<double> _progressAnimation; // Added for progress indication
//   double _progressValue = 0.0;

//   // Define our theme colors
//   final Color _primaryColor = const Color(0xFF2A4759);
//   final Color _complementaryColor = const Color(0xFFB08A67);
//   final Color _accentColor = const Color(0xFFE8C19A);

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 10), // Increased duration to 10 seconds
//       vsync: this,
//     );

//     _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );

//     _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate( // Animate from 0 to 1
//       CurvedAnimation(parent: _controller, curve: Curves.linear), // Use linear curve
//     );

//      _progressAnimation.addListener(() { //listen to animation changes
//       setState(() {
//         _progressValue = _progressAnimation.value; //update value
//       });
//     });

//     _controller.forward();


//     Timer(const Duration(seconds: 10), () { // Match the timer with the animation duration
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const SignInPage()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           color: _primaryColor,
//         ),
//         child: FadeTransition(
//           opacity: _opacityAnimation,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/motofix.png',
//                   height: 150,
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.error, color: Colors.redAccent, size: 60),
//                 ),
//                 const SizedBox(height: 40),
//                 // Use a LinearProgressIndicator for a progress bar
//                  SizedBox(
//                   width: 200, // Set a fixed width for the progress bar
//                   child: LinearProgressIndicator(
//                     value: _progressValue, // Bind the animation value
//                     backgroundColor: Colors.white30, // Background color for the bar
//                     valueColor: AlwaysStoppedAnimation<Color>(_accentColor), // Progress color
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   "MOTOFIX",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Your trusted partner for vehicle care",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




