import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/constants.dart';


class SideBarTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SideBarTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 70,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected
                  ? primaryMaterialColor.shade300
                  : primaryMaterialColor.shade100,
              border:
                  isSelected ? Border.all(color: primaryColor, width: 2) : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ]
                  : [],
            ),
            alignment: Alignment.center,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.fredoka(
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color:
                    isSelected ? primaryMaterialColor.shade900 : darkGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
