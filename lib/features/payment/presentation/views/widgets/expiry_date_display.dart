import 'package:docdoc_app/core/styles/app_text_styles.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ExpiryDateDisplay extends StatelessWidget {
  const ExpiryDateDisplay({
    super.key,
    required this.expiryMonth,
    required this.expiryYear,
  });
  final String expiryMonth, expiryYear;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expiry Date',
          style: AppTextStyles.font14Normal.copyWith(fontSize: 16, height: 1),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$expiryMonth/$expiryYear',
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
