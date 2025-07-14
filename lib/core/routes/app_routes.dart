import 'package:docdoc_app/features/onboard/presentation/views/on_board_view.dart';
import 'package:docdoc_app/features/payment/presentation/views/add_payment_method_view.dart';
import 'package:docdoc_app/features/payment/presentation/views/payment_view.dart';
import 'package:docdoc_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kOnBoardView = '/onBoardView';
  static const kSplashView = '/';
  static const kLoginView = '/loginView';
  static const kPaymentMethods = '/paymentMethods';
  static const kAddNewPaymentMethod = '/addPaymentMethod';

  static GoRouter router = GoRouter(
    initialLocation: kPaymentMethods,
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
      GoRoute(
        path: kAddNewPaymentMethod,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const AddPaymentMethodView(),
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
      GoRoute(
        path: kPaymentMethods,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const PaymentView(),
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
