import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/constants.dart';

class ProfileTile extends StatelessWidget {
  final String name;
  final String email;
  final String? url;
  const ProfileTile(
      {super.key, required this.name, required this.email, this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Circular Avatar Container
          Container(
            height: 70, // Adjusted size
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
              image: DecorationImage(
                image: NetworkImage(
                  url != null && url!.isNotEmpty ? url! : '',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 15), // Space between avatar and text

          // Name and Email Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, $name',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: darkGreyColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: darkGreyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),

          // Arrow Icon
          SvgPicture.asset(
            'assets/icons/miniRight.svg',
            height: 30,
            // ignore: deprecated_member_use
            color: greyColor,
          )
        ],
      ),
    );
  }
}
