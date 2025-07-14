import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CreditCardTypeDetails extends StatelessWidget {
  const CreditCardTypeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text('Expiry Date', style: AppTextStyles.expiryDateTitle9Normal),
            SizedBox(height: 10),
            Text('24/2000', style: AppTextStyles.expiryDate13Normal),
          ],
        ),
        SizedBox(width: 30),
        Column(
          children: [
            Text('CCV', style: AppTextStyles.expiryDateTitle9Normal),
            SizedBox(height: 10),
            Text('120', style: AppTextStyles.expiryDate13Normal),
          ],
        ),
        Spacer(),
        Image.asset(
          Images.imagesImagesMasterCard,
          fit: BoxFit.scaleDown,
          height: 60,
          width: 60,
        ),
      ],
    );
  }
}
