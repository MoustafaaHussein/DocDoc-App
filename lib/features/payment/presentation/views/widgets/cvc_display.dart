import 'package:docdoc_app/core/styles/app_text_styles.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CvcDisplay extends StatelessWidget {
  const CvcDisplay({super.key, required this.cvc});
  final String cvc;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CVC',
          style: AppTextStyles.font14Normal.copyWith(fontSize: 16, height: 1),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              cvc,
              style: AppTextStyles.font14Normal.copyWith(
                color: Colors.white,
                height: 1,
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 10),
        Divider(color: AppColors.kDviderColor, thickness: 1),
      ],
    );
  }
}
