import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProMemberShipFeatures extends StatelessWidget {
  const ProMemberShipFeatures({super.key, required this.feature});
  final String feature;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Images.imagesImagesCheckMark),
        SizedBox(width: 10),
        Text(
          feature,
          style: AppStyles.styleMedium16(context).copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
