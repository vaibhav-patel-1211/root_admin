import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/component/custom_textfield.dart';
import 'package:root_admin/constants.dart';
import 'package:root_admin/screens/Auth/auth_service.dart';
import 'package:root_admin/screens/Auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = Get.find();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // For showing loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor5,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  // Title
                  Text(
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email Field with Validator
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: "Email",
                    iconPath: "assets/icons/Message.svg",
                    validator: emaildValidator.call,
                  ),
                  const SizedBox(height: 16),

                  // Password Field with Validator
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: "Password",
                    iconPath: "assets/icons/Lock.svg",
                    obscureText: true,
                    validator: passwordValidator.call,
                  ),
                  const SizedBox(height: 20),

                  // Forgot Password
                  TextButton(
                    child: Text(
                      "Forgot password?",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_emailController.text.isNotEmpty) {
                        authService.resetPassword(_emailController.text);
                      } else {
                        Get.snackbar(
                          "Warning",
                          "Please enter your email first.",
                          colorText: darkGreyColor,
                          duration: const Duration(seconds: 3),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 30),

                  // Login Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);

                          // Call the login method from AuthService
                          await AuthService.instance.login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );

                          setState(() => _isLoading = false);
                        }
                      },
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Log in",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: blackColor80,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
