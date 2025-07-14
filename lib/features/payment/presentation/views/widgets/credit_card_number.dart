import 'package:docdoc_app/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CreditCardNumber extends StatelessWidget {
  const CreditCardNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('1234', style: AppTextStyles.font24Light),
          ),
        ),
        SizedBox(width: 30),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('1234', style: AppTextStyles.font24Light),
          ),
        ),
        SizedBox(width: 30),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('1234', style: AppTextStyles.font24Light),
          ),
        ),
        SizedBox(width: 30),
        Flexible(
          child: FittedBox(
            child: Text('1234', style: AppTextStyles.font24Light),
          ),
        ),
        SizedBox(width: 30),
      ],
    );
  }
}
