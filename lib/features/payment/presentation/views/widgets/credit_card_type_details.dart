import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreditCardTypeDetails extends StatelessWidget {
  const CreditCardTypeDetails({
    super.key,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvc,
    required this.cardType,
  });
  final String expiryMonth, expiryYear, cvc, cardType;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              'Expiry Date',
              style: AppStyles.styleMedium13(
                context,
              ).copyWith(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              '$expiryMonth/$expiryYear',
              style: AppStyles.styleMedium13(
                context,
              ).copyWith(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(width: 30),
        Column(
          children: [
            Text(
              'CCV',
              style: AppStyles.styleMedium13(
                context,
              ).copyWith(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              cvc,
              style: AppStyles.styleMedium13(
                context,
              ).copyWith(color: Colors.grey),
            ),
          ],
        ),
        Spacer(),
        SvgPicture.asset(
          cardType == "Mastercard"
              ? Images.imagesImagesMasterCard
              : Images.imagesImagesVisa,

          fit: BoxFit.scaleDown,
          height: 60,
          width: 60,
        ),
      ],
    );
  }
}
