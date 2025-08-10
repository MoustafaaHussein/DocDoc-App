import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
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
          'cardholder_name'.tr(),
          style: AppStyles.styleMedium16(
            context,
          ).copyWith(fontSize: 16, height: 1),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(Images.imagesImagesPerson, fit: BoxFit.fill),
            const SizedBox(width: 25),
            Text(
              cardHolderName,
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: Colors.white, height: 1),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: AppColors.kDviderColor, thickness: 1),
      ],
    );
  }
}
