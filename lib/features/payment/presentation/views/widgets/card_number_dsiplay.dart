import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/styles/app_text_styles.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardNumber extends StatelessWidget {
  const CardNumber({
    super.key,
    required this.cardNumber,
    required this.cardType,
  });
  final String cardNumber;
  final String cardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Number',
          style: AppTextStyles.font14Normal.copyWith(fontSize: 16, height: 1),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Images.imagesImagesCreditCard,
              fit: BoxFit.fill,
              // color: Colors.white,
            ),
            SizedBox(width: 25),
            Text(
              '${cardNumber.substring(0, 4)} ${cardNumber.substring(4, 8)} ${cardNumber.substring(8, 12)} ${cardNumber.substring(12, 16)}',
              style: AppTextStyles.font14Normal.copyWith(
                color: Colors.white,
                height: 1,
              ),
            ),
            Spacer(),
            SvgPicture.asset(
              cardType == 'MasterCard'
                  ? Images.imagesImagesMasterCard
                  : Images.imagesImagesVisa,
              fit: BoxFit.scaleDown,
              width: 40,
              height: 40,
            ),
          ],
        ),
        SizedBox(height: 10),
        Divider(color: AppColors.kDviderColor, thickness: 1),
      ],
    );
  }
}
