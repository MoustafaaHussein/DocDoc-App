import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class OnBoardPageViewItems extends StatelessWidget {
  const OnBoardPageViewItems({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            height: 350,
            width: 350,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.center,
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: AppColors.kSubTitleColor),
        ),
      ],
    );
  }
}
