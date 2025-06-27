import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/Profile/profile_screen.dart';
import 'package:root_admin/Profile/profile_service.dart';
import 'package:root_admin/component/app_bar.dart';
import 'package:root_admin/component/custom_textfield.dart';
import 'package:root_admin/constants.dart';

class ChangePassword2 extends StatefulWidget {
  const ChangePassword2({super.key});

  @override
  State<ChangePassword2> createState() => _ChangePassword2State();
}

class _ChangePassword2State extends State<ChangePassword2> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
                  'Set new password',
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
                  'Your new password must be different from your previously used password.',
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
                  hintText: "New password",
                  iconPath: "assets/icons/Lock.svg",
                  obscureText: true,
                  validator: (value) {
                    if (_errorText != null) {
                      return _errorText;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  hintText: "New password again",
                  iconPath: "assets/icons/Lock.svg",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
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
            if (_formKey.currentState!.validate()) {
              try {
                await profileService.updatePassword(
                    data['currentPassword'], _passwordController.text);
                Get.offAll(ProfileScreen());
              } on FirebaseAuthException catch (e) {
                setState(() {
                  if (e.code == 'weak-password') {
                    _errorText = 'The password provided is too weak';
                  } else {
                    _errorText = e.message;
                  }
                });
                _formKey.currentState!.validate();
              }
            }
          },
          child: Text(
            "Change Password",
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
