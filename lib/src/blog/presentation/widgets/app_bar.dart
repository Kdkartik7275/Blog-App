import 'package:blog/core/utils/constants/images.dart';
import 'package:blog/src/blog/presentation/widgets/home_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 160,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SvgPicture.asset(
          AppImages.appLogo,
        ),
      ),
      actions: const [
        HomeMenu(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
