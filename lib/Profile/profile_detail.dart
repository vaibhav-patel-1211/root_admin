import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/Profile/change_password.dart';
import 'package:root_admin/Profile/components/profile_header.dart';
import 'package:root_admin/Profile/components/profile_info_tile.dart';
import 'package:root_admin/Profile/edit_profile.dart';
import 'package:root_admin/component/app_bar.dart';
import 'package:root_admin/constants.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        child: Padding(
          padding: const EdgeInsets.only(right: defaultPadding),
          child: GestureDetector(
            onTap: () {
              Get.to(const EditProfile(), arguments: {
                'name': data['name'],
                'email': data['email'],
                'profileImage': data['profileImage']
              });
            },
            child: Text(
              'Edit',
              style: GoogleFonts.fredoka(
                textStyle: const TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: ProfileHeader(
                name: data['name'],
                email: data['email'],
                url: data['image'],
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            // user information

            //name
            ProfileInfoTile(title: 'Name', info: data['name']),
            const SizedBox(
              height: defaultPadding,
            ),
            // email
            ProfileInfoTile(title: 'Email', info: data['email']),
            const SizedBox(
              height: defaultPadding,
            ),
            // password
            ProfileInfoTile(
              title: 'Password',
              info: 'Change password',
              color: primaryColor,
              onTap: () {
                Get.to(
                  ChangePassword(),
                  arguments: {
                    'name': data['name'],
                    'email': data['email'],
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
