


import 'package:docdoc_app/features/Profile/presentation/views/widgets/ProfileHeader.dart';
import 'package:docdoc_app/features/Profile/presentation/views/widgets/SettingTile.dart' show SettingsTile;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ProfileHeaderScreen(),
          SizedBox(height: 24.h),
          
        ],
      ),
    );
  }
}
