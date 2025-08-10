import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/features/AiSession/presentation/views/widgets/AiSessionHeader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AiIntroWidget extends StatelessWidget {
  const AiIntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFECD8C5),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color.fromARGB(180, 215, 215, 231),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                IconlyLight.arrowLeft2,
                color: Color.fromARGB(255, 6, 6, 6),
                size: 25,
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const AisessionHeader(),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'advise_you'.tr(),
                    style: AppStyles.styleSemiBold24(
                      context,
                    ).copyWith(color: const Color.fromARGB(255, 20, 20, 21)),
                  ),
                ),
                Expanded(
                  child: Text(
                    'three_keys'.tr(),
                    style: AppStyles.styleMedium18(
                      context,
                    ).copyWith(color: const Color.fromARGB(153, 109, 108, 108)),
                  ),
                ),
              ],
            ),
          ),
          _buildItem(
            image: "assets/images/seelfCare.png",
            text: "what_is_self_care".tr(),
          ),
          _buildItem(
            image: "assets/images/Image1.png",
            text: "when_and_how_practice".tr(),
          ),
          _buildItem(
            image: "assets/images/Image2.png",
            text: "how_self_care_improves".tr(),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                GoRouter.of(
                  context,
                ).pushReplacement(AppRouter.kEmotiomDetectorView);
              },
              child: Container(
                width: 300.h,
                height: 65.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFECD8C5),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  'start'.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w600,
                    height: 1.16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({required String image, required String text}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(image, height: 50.h, width: 50.w, fit: BoxFit.cover),
              SizedBox(width: 12.w),
              Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF1C1B1F),
                  fontSize: 16,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w400,
                  height: 1.20,
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.4),
      ],
    );
  }
}
