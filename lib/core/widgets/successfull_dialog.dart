import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SuccessDialogWidget extends StatelessWidget {
  final VoidCallback onSubmit;
  final String titileText, subTittle;

  const SuccessDialogWidget({
    super.key,
    required this.onSubmit,
    required this.titileText,
    required this.subTittle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.kDarkModeBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.kButtonPrimaryColor,
                  width: 2,
                ),
              ),
              child: Image.asset(
                Images.imagesImagesSuccessfulmessage,
                width: 36,
                height: 36,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              titileText,
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subTittle,
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: Color(0xFF98A2B3)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child:  Text(
                  'Continue'.tr(),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
