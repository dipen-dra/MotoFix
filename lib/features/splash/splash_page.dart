import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motofix_app/feature/auth/presentation/view/signin_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _progressAnimation;
  double _progressValue = 0.0;

  // Define theme colors
  final Color _primaryColor = const Color(0xFF2A4759);       // Deep blue-grey
  final Color _complementaryColor = const Color(0xFFB08A67); // Warm brown
  final Color _accentColor = const Color(0xFFE8C19A);         // Light peach

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4), // Match timer and animation
      vsync: this,
    ); 

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _progressAnimation.addListener(() {
      setState(() {
        _progressValue = _progressAnimation.value;
      });
    });

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
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
        color: _primaryColor,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/motofix_logo.png',
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, color: Colors.redAccent, size: 60),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    value: _progressValue,
                    backgroundColor: _complementaryColor.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(_accentColor),
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