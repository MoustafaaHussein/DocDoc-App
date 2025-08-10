import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:flutter/material.dart';

class CvcDisplay extends StatelessWidget {
  const CvcDisplay({super.key, required this.cvc});
  final String cvc;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CVC', style: AppStyles.styleMedium16(context)),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              cvc,
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
