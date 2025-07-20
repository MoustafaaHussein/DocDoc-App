import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/QuoteCard.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/SpecialAppBar.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/customTypes.dart';
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
                  "Emotion Recognizer",
                  style: Textstyles.font22White500Weight,
                ),
                Text('Ai Features ✨', style: Textstyles.font14Grey400Weight),
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
                        '1 on 1 Sessions',
                        style: Textstyles.font22Brown800Weight,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Let’s open up to the things that\n matter the most ",
                        style: Textstyles.font12Brown400Weight,
                      ),
                      SizedBox(height: 5.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subscribe Now! ",
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
              child: Row(
                children: [
                  CustomJournalTile(
                    title: 'Exercise',
                    icon: IconlyLight.activity,
                  ),
                  const CustomJournalTile(
                    title: 'Meditation',
                    icon: Icons.self_improvement,
                  ),
                  CustomJournalTile(
                    title: 'Mental',
                    icon: Ionicons.bonfire_outline,
                  ),
                  const CustomJournalTile(
                    title: 'Self Care',
                    icon: Ionicons.moon_outline,
                  ),
                ],
              ),
            ),

            SizedBox(height: 15.h),

            QuoteCard(
              quote:
                  " “ It is better to conquer yourself than to win a thousand battles ” ",
            ),
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
                        'How would you describe your mood?',
                        style: Textstyles.font22Black800Weight,
                      ),

                      SizedBox(height: 5.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Chek It Now !",
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
