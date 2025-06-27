import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/Profile/change_password2.dart';
import 'package:root_admin/Profile/profile_service.dart';
import 'package:root_admin/component/app_bar.dart';
import 'package:root_admin/component/custom_textfield.dart';
import 'package:root_admin/constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    final ProfileService profileService = Get.find<ProfileService>();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Password',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.fredoka(
                    textStyle: const TextStyle(
                      color: darkGreyColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter your current password to reset password',
                  style: GoogleFonts.fredoka(
                    textStyle: const TextStyle(
                      color: darkGreyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: defaultPadding + 20,
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: "Password",
                  iconPath: "assets/icons/Lock.svg",
                  obscureText: true,
                  validator: (value) {
                    if (_errorText != null) {
                      return _errorText;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            setState(() {
              _errorText = null;
            });
            try {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                await user.reauthenticateWithCredential(
                  EmailAuthProvider.credential(
                    email: user.email!,
                    password: _passwordController.text.trim(),
                  ),
                );
                // Password is correct, proceed with navigation
                Get.to(const ChangePassword2(), arguments: {
                  'currentPassword': _passwordController.text.trim()
                });
              }
            } catch (e) {
              setState(() {
                _errorText = 'Current password is incorrect';
              });
              _formKey.currentState?.validate();
            }
          },
          child: Text(
            "Next",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
