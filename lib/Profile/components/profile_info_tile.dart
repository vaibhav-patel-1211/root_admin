import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/constants.dart';

class ProfileInfoTile extends StatelessWidget {
  final String title;
  final String info;
  final VoidCallback? onTap;
  final Color? color;

  const ProfileInfoTile({
    super.key,
    required this.title,
    required this.info,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.fredoka(
                  textStyle: const TextStyle(
                    color: darkGreyColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  info,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.fredoka(
                    textStyle: TextStyle(
                      color: color ?? darkGreyColor, // ✅ Use default if null
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Divider(
          height: 3,
          thickness: 1.5,
          color: primaryMaterialColor.shade50,
        ),
      ],
    );
  }
}
