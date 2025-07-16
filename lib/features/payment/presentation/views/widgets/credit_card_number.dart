import 'package:docdoc_app/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CreditCardNumber extends StatelessWidget {
  const CreditCardNumber({super.key, required this.cardNumber});
  final String cardNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              cardNumber.substring(0, 4),
              style: AppTextStyles.font24Light,
            ),
          ),
        ),
        SizedBox(width: 30),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              cardNumber.substring(4, 8),
              style: AppTextStyles.font24Light,
            ),
          ),
        ),
        SizedBox(width: 30),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              cardNumber.substring(8, 12),
              style: AppTextStyles.font24Light,
            ),
          ),
        ),
        SizedBox(width: 30),
        Flexible(
          child: FittedBox(
            child: Text(
              cardNumber.substring(12, 16),
              style: AppTextStyles.font24Light,
            ),
          ),
        ),
        SizedBox(width: 30),
      ],
    );
  }
}
