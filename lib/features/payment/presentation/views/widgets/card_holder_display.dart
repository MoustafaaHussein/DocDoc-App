import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/styles/app_text_styles.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardHolderNameDisplay extends StatelessWidget {
  const CardHolderNameDisplay({super.key, required this.cardHolderName});
  final String cardHolderName;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cardholder Name',
          style: AppTextStyles.font14Normal.copyWith(fontSize: 16, height: 1),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(Images.imagesImagesPerson, fit: BoxFit.fill),
            SizedBox(width: 25),
            Text(
              cardHolderName,
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
