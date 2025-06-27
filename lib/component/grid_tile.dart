import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/constants.dart';

class CustomGridTile extends StatelessWidget {
  final String text;
  final String url;

  const CustomGridTile({
    super.key,
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    double maxWidth = 95; // Max width of the container

    // Check if text width exceeds container width
    TextStyle textStyle = GoogleFonts.fredoka(
      textStyle: const TextStyle(
        color: darkGreyColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 100,
          width: maxWidth,
          decoration: BoxDecoration(
            color: primaryMaterialColor.shade100,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: primaryMaterialColor.shade100,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: darkGreyColor,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: primaryMaterialColor.shade100,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ],
    );
  }
}
