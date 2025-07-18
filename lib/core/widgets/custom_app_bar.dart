import 'package:docdoc_app/core/styles/app_containers_style.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:flutter/material.dart';

class CustomizedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomizedAppBar({super.key, this.onTap, required this.title});
  final VoidCallback? onTap;
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.kDarkModeBackgroundColor,
          title: Text(title, style: AppStyles.styleMedium18(context)),
          leading: IconButton(
            onPressed: onTap,
            icon: Container(
              padding: EdgeInsets.all(6),
              decoration: AppContainersStyle.backButtonStyle,
              child: Icon(Icons.arrow_back_ios_new_outlined, fill: 0),
            ),
          ),
        ),
      ),
    );
  }
}
