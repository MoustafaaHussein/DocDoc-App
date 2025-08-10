import 'package:docdoc_app/core/themes/app_styles.dart';
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
              style: AppStyles.styleMediumLight24(context),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              cardNumber.substring(4, 8),
              style: AppStyles.styleMediumLight24(context),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              cardNumber.substring(8, 12),
              style: AppStyles.styleMediumLight24(context),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Flexible(
          child: FittedBox(
            child: Text(
              cardNumber.substring(12, 16),
              style: AppStyles.styleMediumLight24(context),
            ),
          ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }
}
