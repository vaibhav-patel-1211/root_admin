
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/constants.dart';

class GridTitle extends StatelessWidget {
  final String title;
  const GridTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              textStyle: const TextStyle(
                color: darkGreyColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: 1, // Thin horizontal line
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        greyColor,
                        whiteColor,
                      ], // ✅ Use gradient here
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
