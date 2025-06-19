import 'package:flutter/material.dart';
import 'package:motofix_app/features/auth/forget_password.dart';
import 'package:motofix_app/view/dashboard_screen.dart';
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
  bool _isLoading = false;

  void _signIn() async {
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
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (email == "admin123@gmail.com" && password == "admin123") {
      _showSnackBar("Sign-in successful!", Colors.green);

      _emailController.clear();
      _passwordController.clear();
      _emailFocusNode.unfocus();
      _passwordFocusNode.unfocus();

      setState(() {
        _isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MotoFixDashboard()),
      );
      return;
    } else {
      _showSnackBar("Invalid email or password", Colors.red);
    }

    setState(() {
      _isLoading = false;
    });

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFF2A4759),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            _emailFocusNode.unfocus();
            _passwordFocusNode.unfocus();
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 500 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Center(
                          child: Image.asset(
                            'assets/images/motofix_logo.png',
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
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _isEmailValid ? Colors.white : Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
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
                              _isPasswordValid = value.isEmpty ? true : value.length >= 8;
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
                              borderSide: BorderSide(color: _isPasswordValid ? Colors.white30 : Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _isPasswordValid ? Colors.white : Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
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

                        // Sign-in Button
                        ElevatedButton(
                          onPressed: _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF2A4759),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2A4759)),
                                  strokeWidth: 3,
                                )
                              : const Text("SIGN IN", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),

                        const Center(
                          child: Text("Or Sign in with", style: TextStyle(color: Colors.white60)),
                        ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.facebook),
                                label: const Text("Facebook"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[800],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white30),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: Colors.white,
                                ),
                                icon: Image.asset(
                                  "assets/images/image.png",
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.contain,
                                ),
                                label: const Text("Google", style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ],
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
                              child: const Text("Sign up Here",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            )
                          ],
                        ),
                        const SizedBox(height: 50),
                        const Center(
                          child: Text(
                            "Contact Us",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => _launchURL('https://www.instagram.com'),
                              child: Image.asset(
                                'assets/images/insta_logo.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () => _launchURL('https://www.facebook.com'),
                              child: Image.asset(
                                'assets/images/fb_logo.png',
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
            },
          ),
        ),
      ),
    );
  }
}


