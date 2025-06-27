import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileItem extends StatelessWidget {
  final String iconPath; // Path for the main SVG icon
  final String title;
  final VoidCallback onTap;

  const ProfileItem({super.key, 
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24, // Set the icon size
              height: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/Edit-Bold.svg', // Use SVG for edit button
                width: 24,
                height: 24,
              ),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
