import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AisessionHeader extends StatefulWidget {
  const AisessionHeader({super.key});

  @override
  State<AisessionHeader> createState() => _AisessionState();
}

class _AisessionState extends State<AisessionHeader> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          height: screenHeight * 0.50,
          width: double.infinity,
          child: Image.asset('assets/images/Ai_Session.png', fit: BoxFit.cover),
        ),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'take_care_title'.tr(),
                    style: Textstyles.font30Black600Weight,
                  ),
                  Image.asset("assets/images/imageee.png"),
                ],
              ),
              SizedBox(height: 15.h),

              Text(
                "check_mood_fast".tr(),
                style: Textstyles.font14MoreGrey400Weight,
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: 358,
                child: Opacity(
                  opacity: 0.80,
                  child: Text(
                    'self_care_description'.tr(),
                    style: TextStyle(
                      color: const Color(0xFF1C1B1F),
                      fontSize: 13,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                      height: 1.30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
