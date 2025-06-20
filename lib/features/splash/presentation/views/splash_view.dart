import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SplashViewBody(),
      backgroundColor: AppColors.kSplashBackground,
    );
  }
}
