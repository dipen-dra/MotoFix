import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:motofix_app/features/auth/signin_page.dart';

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
  bool _isEmailValid = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAgreed = false;

  String? _passwordErrorText; // New: To store specific password validation errors

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Listen for changes in the password field to provide real-time feedback
    _passwordController.addListener(_validatePasswordRealTime);
  }

  void _validatePasswordRealTime() {
    setState(() {
      _passwordErrorText = _getPasswordValidationMessage(_passwordController.text);
    });
  }


  void _signUp() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Clear previous password error before new validation attempt
    setState(() {
      _passwordErrorText = null;
    });

    if (name.isEmpty || email.isEmpty || fullPhoneNumber.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
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

    // Validate password and get specific feedback
    String? passwordValidationMessage = _getPasswordValidationMessage(password);
    if (passwordValidationMessage != null) {
      setState(() {
        _passwordErrorText = passwordValidationMessage;
      });
      _showSnackBar(passwordValidationMessage, Colors.red);
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

    if (!_termsAgreed) {
      _showSnackBar("Please agree to the terms and conditions", Colors.red);
      return;
    }

    // If all validations pass, clear any existing errors and proceed
    setState(() {
      _isEmailValid = true;
      _isPhoneValid = true;
      _passwordErrorText = null; // Clear password error on successful validation
    });

    _showSnackBar("Sign-up successful!", Colors.green);

    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
    _phoneController.clear();
    _confirmPasswordController.clear();

    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInPage()),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // New method to get specific password validation messages
  String? _getPasswordValidationMessage(String password) {
    if (password.length < 8) {
      return "Password must be at least 8 characters long.";
    }
    if (password.length > 12) {
      return "Password cannot be more than 12 characters long.";
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter.";
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter.";
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number.";
    }
    if (!password.contains(RegExp(r'[!@#\$&*~]'))) {
      return "Password must contain at least one special character (!@#\$&*~).";
    }
    return null; // Password is strong
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

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A4759),
          title: const Text('Terms and Conditions'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('1. Acceptance of Terms', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('By creating an account, you agree to these terms and conditions.'),
                SizedBox(height: 10),
                Text('2. Account Responsibilities', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('You are responsible for maintaining the confidentiality of your account and password.'),
                SizedBox(height: 10),
                Text('3. Use of the Service', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('The service is provided for personal, non-commercial use only.'),
                SizedBox(height: 10),
                Text('4. Privacy Policy', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Your use of the service is also governed by our Privacy Policy.'),
                SizedBox(height: 10),
                Text('5. Modifications', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('We reserve the right to modify these terms at any time.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.removeListener(_validatePasswordRealTime); // Remove listener
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
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isTablet = constraints.maxWidth > 600;
              double horizontalPadding = isTablet ? constraints.maxWidth * 0.2 : 20.0;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Center(child: Image.asset('assets/images/motofix_logo.png', height: 90)),
                        const SizedBox(height: 5),
                        const Text("Sign Up", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 10),
                        const Text("Create your account", style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 30),

                        // Full Name
                        TextField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: "Full Name",
                            labelStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.person, color: Colors.white70),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Email
                        TextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          maxLength: 50,
                          buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                          onChanged: (value) {
                            setState(() {
                              _isEmailValid = value.isEmpty || _isValidEmail(value.trim());
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

                        // Phone
                        IntlPhoneField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
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

                        // Password
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          focusNode: _passwordFocusNode,
                          style: const TextStyle(color: Colors.white),
                          maxLength: 12, // Still enforce max length on the input field
                          buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                          // onChanged is handled by the listener now for _passwordErrorText
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: const TextStyle(color: Colors.white70),
                            prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.white70),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _passwordErrorText == null ? Colors.white30 : Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _passwordErrorText == null ? Colors.white : Colors.red),
                            ),
                            errorText: _passwordErrorText, // Display the specific error message here
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Confirm Password
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          style: const TextStyle(color: Colors.white),
                          maxLength: 12,
                          buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            labelStyle: const TextStyle(color: Colors.white70),
                            prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, color: Colors.white70),
                              onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                            ),
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Terms checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: _termsAgreed,
                              onChanged: (bool? value) {
                                setState(() {
                                  _termsAgreed = value!;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: const Color(0xFF2A4759),
                            ),
                            GestureDetector(
                              onTap: _showTermsAndConditions,
                              child: const Text('I agree to the ', style: TextStyle(color: Colors.white70)),
                            ),
                            GestureDetector(
                              onTap: _showTermsAndConditions,
                              child: const Text('Terms and Conditions', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Sign Up Button
                        ElevatedButton(
                          onPressed: _termsAgreed ? _signUp : null,
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

                        // Social Sign-in
                        const Center(child: Text("Or Sign Up with", style: TextStyle(color: Colors.white60))),
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
                                icon: Image.asset("assets/images/image.png", height: 24, width: 24, fit: BoxFit.contain),
                                label: const Text("Google", style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Sign In Prompt
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
              );
            },
          ),
        ),
      ),
    );
  }
}