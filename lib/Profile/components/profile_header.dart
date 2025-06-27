import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/constants.dart';

class ProfileHeader extends StatelessWidget {
  final String? name;
  final String? email;
  final String? url;
  const ProfileHeader({
    super.key,
    this.name,
    this.email,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // color: greyColor,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.,
        children: [
          // profile photo
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: url != null && url!.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      url!,
                      fit: BoxFit.cover,
                      width: 70,
                      height: 70,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.person, size: 35, color: Colors.grey[400]),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  )
                : Icon(Icons.person, size: 35, color: Colors.grey[400]),
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          // Name and email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name!,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: darkGreyColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: greyColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
