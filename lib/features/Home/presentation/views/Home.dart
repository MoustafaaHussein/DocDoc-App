import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/QuoteCard.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/SpecialAppBar.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/customTypes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString("userFirstName") ?? '';
    final lastName = prefs.getString("userLastName") ?? '';
    setState(() {
      username = '$firstName $lastName';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        userName: username ?? 'User',
        imageUrl: "assets/images/onboard_image1.png",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "emotion_recognizer".tr(),
                  style: AppStyles.styleSemiBold24(
                    context,
                  ).copyWith(color: Colors.white),
                ),
                Text(
                  'ai_features'.tr(),
                  style: AppStyles.styleRegular14(
                    context,
                  ).copyWith(color: const Color(0xFFA2A2A7)),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            InkWell(
              onTap: () {
                GoRouter.of(context).push(AppRouter.kAiSessionView);
              },
              child: Container(
                width: double.infinity,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color.fromARGB(255, 240, 229, 193),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'one_on_one_sessions'.tr(),
                        style: Textstyles.font22Brown800Weight,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "open_up".tr(),
                        style: Textstyles.font12Brown400Weight,
                      ),
                      SizedBox(height: 5.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "subscribe_now".tr(),
                            style: Textstyles.font16Orange700Weight,
                          ),

                          Image.asset("assets/images/Meetup Icon.png"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kRecomendation);
                },
                child: Row(
                  children: [
                    CustomJournalTile(
                      title: 'exercise'.tr(),
                      icon: IconlyLight.activity,
                    ),
                    CustomJournalTile(
                      title: 'meditation'.tr(),
                      icon: Icons.self_improvement,
                    ),
                    CustomJournalTile(
                      title: 'mental'.tr(),
                      icon: Ionicons.bonfire_outline,
                    ),
                    CustomJournalTile(
                      title: 'self_care'.tr(),
                      icon: Ionicons.moon_outline,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15.h),

            QuoteCard(quote: "quote_battle".tr()),
            SizedBox(height: 15.h),
            InkWell(
              onTap: () {
                GoRouter.of(context).push(AppRouter.kEmojiSwitcherView);
              },
              child: Container(
                width: double.infinity,
                height: 220.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color.fromARGB(255, 138, 142, 240),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'describe_your_mood'.tr(),
                        style: Textstyles.font22Black800Weight,
                      ),

                      SizedBox(height: 5.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "check_it_now".tr(),
                            style: Textstyles.font16OWhite700Weight,
                          ),

                          Image.asset("assets/images/MentalHealth.png"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
