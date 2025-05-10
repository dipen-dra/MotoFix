import 'package:flutter/material.dart';
import 'package:motofix_app/features/auth/custom_textfield.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn() {
    // Placeholder for sign-in functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Sign-in functionality not implemented")),
    );
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
              CustomTextField(controller: _emailController, label: "Email "),
              const SizedBox(height: 20),
              CustomTextField(controller: _passwordController, label: "Password", obscureText: true),
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
                child: const Text("SIGN IN"),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
