import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:root_admin/services/cloudinary_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/Profile/profile_service.dart';
import 'package:root_admin/component/app_bar.dart';
import 'package:root_admin/component/custom_textfield.dart';
import 'package:root_admin/constants.dart';
import 'package:root_admin/services/image_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;

    final ProfileService profileService = Get.find<ProfileService>();
    final ImageService imageService = Get.find<ImageService>();

    final TextEditingController emailController =
        TextEditingController(text: data['email']);

    final TextEditingController nameController =
        TextEditingController(text: data['name']);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[200],
                        child: data['profileImage'] != null &&
                                data['profileImage'].toString().isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  data['profileImage'],
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.person,
                                          size: 60, color: Colors.grey[400]),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Icon(Icons.person,
                                size: 60, color: Colors.grey[400]),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 70,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: primaryMaterialColor.shade200, width: 1),
                          ),
                          child: Center(
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/Edit-Bold.svg",
                                    height: 30,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white, // Set icon color to white
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  onPressed: () async {
                                    final String? imagePath =
                                        await imageService.pickImage(context);
                                    if (imagePath != null) {
                                      final cloudinaryService =
                                          CloudinaryService();
                                      final imageUrl = await cloudinaryService
                                          .uploadImage(File(imagePath));
                                      if (imageUrl != null) {
                                        await profileService
                                            .updateProfileImage(imageUrl);
                                        setState(() {
                                          data['profileImage'] = imageUrl;
                                        });
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              CustomTextFormField(
                controller: nameController,
                hintText: "Email",
                iconPath: "assets/icons/Profile.svg",
              ),
              const SizedBox(height: 20),

              // Password Field with Validator
              CustomTextFormField(
                controller: emailController,
                hintText: "Password",
                iconPath: "assets/icons/Message.svg",
                validator: passwordValidator.call,
              ),
            ],
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
          onPressed: () async {},
          child: Text(
            "Done",
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
