
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/constants.dart';

class AvailableBadge extends StatelessWidget {
  const AvailableBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 130,
      decoration: BoxDecoration(
        color: successColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          'Available in stock',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 12,
              color: whiteColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
