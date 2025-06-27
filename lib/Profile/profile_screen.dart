import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/Profile/profile_detail.dart';
import 'package:root_admin/Profile/profile_service.dart';
import 'package:root_admin/component/app_bar.dart';
import 'package:root_admin/component/info-tile.dart';
import 'package:root_admin/component/profile_tile.dart';
import 'package:root_admin/constants.dart';
import 'package:root_admin/screens/Auth/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileService profileService = Get.find();
    final AuthService authService = Get.find();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'profile'.tr,
        leadingPath: '',
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: profileService.getUserDataStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final userData = snapshot.data!.data();
            if (userData == null) {
              return const Center(child: Text('No user data found'));
            }
            final user = AdminModel.fromMap(userData as Map<String, dynamic>);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // profile image
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          const ProfileDetailScreen(),
                          arguments: {
                            'name': user.name,
                            'email': user.email,
                            'image': user.profileImage
                          },
                        );
                      },
                      child: ProfileTile(
                        name: user.name,
                        url: user.profileImage,
                        email: user.email,
                      ),
                    ),
                    // other
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Text(
                        'account'.tr,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: darkGreyColor,
                        )),
                      ),
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Order.svg",
                      name: 'orders'.tr,
                      onTap: () {},
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Return.svg",
                      name: 'return_request'.tr,
                      onTap: () {},
                    ),

                    InfoTile(
                      imgPath: "assets/icons/Wallet.svg",
                      name: 'payment_records'.tr,
                      onTap: () {},
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Text(
                        'settings'.tr,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: darkGreyColor,
                        )),
                      ),
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Language.svg",
                      name: 'language'.tr,
                      onTap: () {
                        Get.defaultDialog(
                          title: 'select_language'.tr,
                          content: Column(
                            children: [
                              ListTile(
                                title: Text('english'.tr),
                                onTap: () {
                                  Get.updateLocale(const Locale('en', 'US'));
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: Text('gujarati'.tr),
                                onTap: () {
                                  Get.updateLocale(const Locale('gu', 'IN'));
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: Text('hindi'.tr),
                                onTap: () {
                                  Get.updateLocale(const Locale('hi', 'IN'));
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Text(
                        'help_support'.tr,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: darkGreyColor,
                        )),
                      ),
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Help.svg",
                      name: 'get_help'.tr,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: // logout button
          Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            authService.signOut();
          },
          child: Text(
            "logout".tr,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
