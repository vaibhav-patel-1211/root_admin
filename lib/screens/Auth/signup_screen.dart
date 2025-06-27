import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/component/custom_textfield.dart';
import 'package:root_admin/constants.dart';
import 'package:root_admin/screens/Auth/auth_service.dart';
import 'package:root_admin/screens/Auth/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false; // Loading state for signup

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor5,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 15),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create New Seller Account",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Name
                  CustomTextFormField(
                    hintText: "Name",
                    iconPath: "assets/icons/Profile.svg",
                    controller: _nameController,
                    validator: (value) =>
                        value!.isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 12),
                  // Email
                  CustomTextFormField(
                    hintText: "Email",
                    iconPath: "assets/icons/Message.svg",
                    controller: _emailController,
                    validator: emaildValidator.call,
                  ),
                  const SizedBox(height: 12),
                  // Password
                  CustomTextFormField(
                    hintText: "Password",
                    iconPath: "assets/icons/Lock.svg",
                    obscureText: true,
                    controller: _passwordController,
                    validator: passwordValidator.call,
                  ),
                  const SizedBox(height: 12),
                  // Confirm Password
                  CustomTextFormField(
                    hintText: "Confirm Password",
                    iconPath: "assets/icons/Lock.svg",
                    obscureText: true,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) return 'Confirm your password';
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Sign Up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);

                          // Call the signUp method from AuthService
                          await AuthService.instance.signUp(
                            _nameController.text.trim(),
                            _emailController.text.trim().toLowerCase(),
                            _passwordController.text.trim(),
                          );

                          setState(() => _isLoading = false);
                        }
                      },
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text("Sign Up"),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login Option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
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
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Log in",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
