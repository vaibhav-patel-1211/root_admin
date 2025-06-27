import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? iconPath;
  final String? leadingPath;
  final Widget? child;
  final String? alternateIconPath; // New icon for toggling
  final VoidCallback? onIconTap; // Callback to handle icon changes

  const CustomAppBar({
    super.key,
    this.title,
    this.iconPath,
    this.child,
    this.leadingPath,
    this.alternateIconPath,
    this.onIconTap,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isIconToggled = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        widget.title ?? '',
        style: GoogleFonts.fredoka(
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: SvgPicture.asset(
          widget.leadingPath ?? "assets/icons/Arrow - Left.svg",
          height: 30,
          colorFilter: ColorFilter.mode(
            Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        if (widget.child != null)
          widget.child!
        else if (widget.iconPath != null && widget.alternateIconPath != null)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isIconToggled = !isIconToggled;
                });

                // Call the provided callback if available
                if (widget.onIconTap != null) {
                  widget.onIconTap!();
                }
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: SvgPicture.asset(
                  isIconToggled ? widget.alternateIconPath! : widget.iconPath!,
                  key: ValueKey<bool>(isIconToggled),
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
