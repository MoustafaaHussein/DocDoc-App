import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CusttomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const CusttomButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 335.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.kButtonPrimaryColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
