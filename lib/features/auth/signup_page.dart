import 'package:flutter/material.dart';
import 'package:motofix_app/features/auth/custom_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _signUp() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }
    // Placeholder for sign-up functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Sign-up functionality not implemented")),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                "Sign Up",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Create your account",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 30),
              CustomTextField(controller: _nameController, label: "Full Name"),
              const SizedBox(height: 20),
              CustomTextField(controller: _emailController, label: "Email"),
              const SizedBox(height: 20),
              CustomTextField(controller: _passwordController, label: "Password", obscureText: true),
              const SizedBox(height: 20),
              CustomTextField(controller: _confirmPasswordController, label: "Confirm Password", obscureText: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp,
                child: const Text("SIGN UP"),
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
                icon: Image.asset(
                  "assets/image.png",
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
                ),
                label: const Text("Sign Up with Google"),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(color: Colors.white60)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Sign in Here",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
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
