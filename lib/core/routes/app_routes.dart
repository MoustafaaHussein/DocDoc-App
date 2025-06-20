import 'package:docdoc_app/features/onboard/presentation/views/on_board_view.dart';
import 'package:docdoc_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kOnBoardView = '/onBoardView';
  static const kSplashView = '/';
  static const kLoginView = '/loginView';

  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnBoardView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const OnBoardView(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
    ],
  );
}
