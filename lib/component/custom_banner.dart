import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/constants.dart';

class CustomBanner extends StatefulWidget {
  final String imagePath;
  final String title;
  final List<String> subtexts;
  final String promoCode;

  const CustomBanner({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtexts,
    required this.promoCode,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomBannerState createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.subtexts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Product Image
          Image.asset(
            widget.imagePath,
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Animated Subtext with Slide Up and Fade Effect
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: (child.key ==
                                ValueKey(widget.subtexts[_currentIndex]))
                            ? const Offset(0, 0.5) // New text enters from below
                            : const Offset(
                                0, -0.5), // Old text exits by going up
                        end: const Offset(0, 0),
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    widget.subtexts[_currentIndex],
                    key: ValueKey<String>(widget.subtexts[_currentIndex]),
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: darkGreyColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Use code: ${widget.promoCode}',
                  style: GoogleFonts.fredoka(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: primaryMaterialColor.shade500,
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
