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
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: AppColors.kSubTitleColor),
        ),
      ],
    );
  }
}
