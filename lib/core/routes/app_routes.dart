import 'package:docdoc_app/features/AiModel/Presentation/views/EmotionDetectorScreen.dart';
import 'package:docdoc_app/features/AiSession/presentation/views/Ai_View.dart';
import 'package:docdoc_app/features/Home/presentation/views/CustomNavigationBar.dart';
import 'package:docdoc_app/features/Home/presentation/views/Home.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/emojySwitcher.dart';
import 'package:docdoc_app/features/Login/presentation/views/LoginScreen.dart';
import 'package:docdoc_app/features/PersonInformation/presentation/views/PersonInformation.dart';
import 'package:docdoc_app/features/SignUP/presentation/views/SignUP_Screen.dart';
import 'package:docdoc_app/features/onboard/presentation/views/on_board_view.dart';
import 'package:docdoc_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kOnBoardView = '/onBoardView';
  static const kSplashView = '/ss';
  static const kAiSessionView = '/AiSessionView';
  static const kEmotiomDetectorView = '/EmotiomDetectorView';
  static const kLoginView = '/loginView';
  static const kEmojiSwitcherView = '/EmojiSwitcherView';
  static const kSignUpView = '/';
  static const kHomeView = '/homeView';
  static const kPersonInformationView = '/PersonInformationView';
  static const kHomePage = '/homepage';

  /// ✅ الدالة اللي هترجع الراوتر المناسب
  static GoRouter initRouter({required bool isLoggedIn}) {
    return GoRouter(
      initialLocation: isLoggedIn ? kHomePage : kLoginView,
      routes: [
        GoRoute(path: kHomePage, builder: (context, state) => const HomePage()),
        GoRoute(
          path: kEmotiomDetectorView,
          builder: (context, state) => const EmotionDetectorScreen(),
        ),
        GoRoute(
          path: kAiSessionView,
          builder: (context, state) => const AiView(),
        ),
        GoRoute(
          path: kEmojiSwitcherView,
          builder: (context, state) => const EmojiSwitchScreen(),
        ),
        GoRoute(
          path: kSplashView,
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: kPersonInformationView,
          builder: (context, state) => const Personinformation(),
        ),
        GoRoute(
          path: kHomeView,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: kLoginView,
          builder: (context, state) => const Loginscreen(),
        ),
        GoRoute(
          path: kSignUpView,
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: kOnBoardView,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: const OnBoardView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
      ],
    );
  }
}
