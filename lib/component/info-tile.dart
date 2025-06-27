import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:root_admin/constants.dart';

class InfoTile extends StatelessWidget {
  final String imgPath;
  final String name;
  final VoidCallback onTap;

  const InfoTile({
    super.key,
    required this.imgPath,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ListTile(
            leading: SvgPicture.asset(
              imgPath,
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!, BlendMode.srcIn),
            ),
            title: Text(name),
            trailing: SvgPicture.asset(
              "assets/icons/miniRight.svg",
              height: 30,
              // ignore: deprecated_member_use
              color: greyColor,
            ),
          ),
        ),
        const Divider(
          color: greyColor,
          endIndent: 0.0,
        )
      ],
    );
  }
}
