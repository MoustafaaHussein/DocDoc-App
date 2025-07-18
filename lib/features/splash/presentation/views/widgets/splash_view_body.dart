import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/features/splash/presentation/views/widgets/image_mirror_animation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    handlingNavigation();
    super.initState();
  }

  void handlingNavigation() {
    Future.delayed(const Duration(seconds: 6), () {
      // Navigate to the next screen after the delay
      GoRouter.of(context).pushReplacement(AppRouter.kOnBoardView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: ImageMirrorAnimation()),
        Text(
          'My Mood ',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
      ],
    );
  }
}
