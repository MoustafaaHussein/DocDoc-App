import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
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
          'card_number'.tr(),
          style: AppStyles.styleRegular14(
            context,
          ).copyWith(fontSize: 16, height: 1),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Images.imagesImagesCreditCard,
              fit: BoxFit.fill,
              // color: Colors.white,
            ),
            const SizedBox(width: 25),
            Text(
              '${cardNumber.substring(0, 4)} ${cardNumber.substring(4, 8)} ${cardNumber.substring(8, 12)} ${cardNumber.substring(12, 16)}',
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: Colors.white, height: 1),
            ),
            const Spacer(),
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
        const SizedBox(height: 10),
        const Divider(color: AppColors.kDviderColor, thickness: 1),
      ],
    );
  }
}
