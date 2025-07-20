import 'package:dio/dio.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/Profile/presentation/views/widgets/SettingTile.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/repo/SignUpRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileHeaderScreen extends StatefulWidget {
  const ProfileHeaderScreen({super.key});

  @override
  State<ProfileHeaderScreen> createState() => _ProfileHeaderScreenState();
}

class _ProfileHeaderScreenState extends State<ProfileHeaderScreen> {
  bool isDarkMode = false;

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // الخلفية
        SizedBox(
          height: screenHeight * 0.99,
          width: double.infinity,
          child: Image.asset('assets/images/wet leaves.jpg', fit: BoxFit.cover),
        ),

        // الكونتينر الأبيض
        Positioned(
          top: screenHeight * 0.25,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.kDarkModeBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
          ),
        ),

        // المحتوى الكامل داخل ScrollView
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.h),

                // أزرار العنوان
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Icon(Icons.more_vert, color: Colors.white),
                    ],
                  ),
                ),

                SizedBox(height: 80.h),

                // صورة البروفايل
                Center(
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: const CircleAvatar(
                      radius: 44,
                      backgroundImage: AssetImage(
                        'assets/images/onboard_image1.png',
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // الاسم
                Text(
                  username ?? 'User',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),

                // العضوية
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF0CE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'BASIC MEMBER',
                    style: TextStyle(
                      color: Color(0xFF5E814E),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // البيانات
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _InfoItem(title: 'Age', value: '17y'),
                    _InfoItem(title: 'Weight', value: '48kg'),
                    _InfoItem(title: 'Height', value: '162cm'),
                  ],
                ),

                SizedBox(height: 24.h),

                // SettingsTile(
                //   icon: Ionicons.analytics_outline,
                //   title: "Invite Friends",
                // ),
                // SizedBox(height: 8.h),
                SettingsTile(
                  icon: Ionicons.person_outline,
                  title: "Personal Information",
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kPersonInformationView);
                  },
                ),
                SizedBox(height: 8.h),
                SettingsTile(
                  icon: Ionicons.wallet_outline,
                  title: "Your Cards",
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kEmojiSwitcherView);
                  },
                ),
                SizedBox(height: 8.h),
                SettingsTile(
                  icon: Ionicons.moon_outline,
                  title: "Dark Mode",
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (val) {
                      setState(() => isDarkMode = val);
                    },
                  ),
                ),
                SizedBox(height: 8.h),
                SettingsTile(
                  icon: Ionicons.log_out_outline,
                  title: "Log Out",
                  onTap: () async {
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text("Confirm Logout"),
                            content: const Text(
                              "Are you sure you want to log out?",
                            ),
                            actions: [
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(false),
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(true),
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                    );

                    if (shouldLogout == true) {
                      final repo = AuthRepository(dio: Dio());
                      await repo.logout();

                      if (context.mounted) {
                        context.go(AppRouter.kLoginView);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
