import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/PersonInformation/presentation/views/widgets/BirthDateSelect.dart';
import 'package:docdoc_app/features/PersonInformation/presentation/views/widgets/ProfileInfoTile.dart';
import 'package:docdoc_app/features/PersonInformation/presentation/views/widgets/editImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Personinformation extends StatefulWidget {
  const Personinformation({super.key});

  @override
  State<Personinformation> createState() => _PersoninformationState();
}

class _PersoninformationState extends State<Personinformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
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
                EditableProfileImage(),
                SizedBox(height: 15.h),

                Text("Taher Farh", style: Textstyles.font16White400Weight),
                ProfileInfoTile(
                  label: 'Full Name',
                  value: 'Taher Farh',
                  icon: IconlyLight.profile,
                ),
                Divider(),
                SizedBox(height: 15.h),
                ProfileInfoTile(
                  label: 'Email Address',
                  value: 'Taher.Farh@gmail.com',
                  icon: IconlyLight.message,
                ),
                Divider(),
                SizedBox(height: 15.h),
                ProfileInfoTile(
                  label: 'Phone Number',
                  value: '+201002855077',
                  icon: IconlyLight.call,
                ),
                Divider(),
                BirthDateTile(
                  onDateSelected: (date) {
                    print('Selected birth date: $date');
                  },
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
