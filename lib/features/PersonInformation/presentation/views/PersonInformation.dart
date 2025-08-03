import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/PersonInformation/presentation/views/widgets/ProfileInfoTile.dart';
import 'package:docdoc_app/features/PersonInformation/presentation/views/widgets/editImage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Personinformation extends StatefulWidget {
  const Personinformation({super.key});

  @override
  State<Personinformation> createState() => _PersoninformationState();
}

class _PersoninformationState extends State<Personinformation> {
  String? fullName;
  String? email;
  String? phone;
  String? dob;
  String? profilePicture;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString("userFirstName") ?? '';
    final lastName = prefs.getString("userLastName") ?? '';
    setState(() {
      fullName = "$firstName $lastName";
      email = prefs.getString("userEmail") ?? '';
      phone = prefs.getString("userPhone") ?? '';
      dob = prefs.getString("userDob") ?? '';
      profilePicture = prefs.getString("profilePicture") ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("person_info".tr()),
        centerTitle: true,
        backgroundColor: AppColors.kDarkModeBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E2D),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(IconlyLight.arrowLeft2, color: Colors.white, size: 20),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(height: 15.h),
            Column(
              children: [
                EditableProfileImage(imageUrl: profilePicture),
                SizedBox(height: 15.h),
                Text(fullName ?? '', style: Textstyles.font16White400Weight),
                ProfileInfoTile(
                  label: 'full_name'.tr(),
                  value: fullName ?? '',
                  icon: IconlyLight.profile,
                ),
                Divider(),
                SizedBox(height: 15.h),
                ProfileInfoTile(
                  label: 'email_address'.tr(),
                  value: email ?? '',
                  icon: IconlyLight.message,
                ),
                Divider(),
                SizedBox(height: 15.h),
                ProfileInfoTile(
                  label: 'phone_number'.tr(),
                  value: phone ?? '',
                  icon: IconlyLight.call,
                ),
                Divider(),
                SizedBox(height: 15.h),
                ProfileInfoTile(
                  label: 'date_of_birth'.tr(),
                  value: dob ?? '',
                  icon: IconlyLight.calendar,
                ),
                Divider(),
                // BirthDateTile(
                //   initialDate: dob != null ? DateTime.tryParse(dob!) : null,
                //   onDateSelected: (date) {
                //     print('Selected birth date: $date');
                //   },
                // ),
                // Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
