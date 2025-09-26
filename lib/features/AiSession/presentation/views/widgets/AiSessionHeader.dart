import 'package:docdoc_app/core/themes/app_styles.dart';
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

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            child: Image.asset(
              'assets/images/Ai_Session.png',
              fit: BoxFit.cover,
            ),
          ),
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
                  // Text with flexible space
                  Expanded(
                    flex: 3,
                    child: Text(
                      'take_care_title'.tr(),
                      style: AppStyles.styleSemiBold30(
                        context,
                      ).copyWith(color: const Color(0xFF1C1B1F)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(width: 12), // spacing between text and image
                  // Image that grows with screen size but never overflows
                  Flexible(
                    flex: 1,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Image.asset(
                          "assets/images/imageee.png",
                          width: constraints.maxWidth,
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15.h),

              Text(
                "check_mood_fast".tr(),
                style: AppStyles.styleMedium16(
                  context,
                ).copyWith(color: const Color.fromARGB(255, 116, 116, 117)),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: 358,
                child: Opacity(
                  opacity: 0.80,
                  child: Text(
                    'self_care_description'.tr(),
                    style: AppStyles.styleMedium16(
                      context,
                    ).copyWith(color: const Color(0xFF1C1B1F)),
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
