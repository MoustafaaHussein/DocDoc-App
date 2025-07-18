import 'package:docdoc_app/core/helpers/service_locator.dart';
import 'package:docdoc_app/features/onboard/presentation/views/on_board_view.dart';
import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';
import 'package:docdoc_app/features/payment/domain/repos/payment_repositry.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/payment_bloc.dart';
import 'package:docdoc_app/features/payment/presentation/views/add_payment_method_view.dart';
import 'package:docdoc_app/features/payment/presentation/views/credit_card_details_view.dart';
import 'package:docdoc_app/features/payment/presentation/views/payment_view.dart';
import 'package:docdoc_app/features/recomendation/domain/repos/recomendation_repo.dart';
import 'package:docdoc_app/features/recomendation/presentation/manger/bloc/recomendation_bloc.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/presonalize_recomendation_view.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/recomendation_by_category_view.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/recomendation_view.dart';
import 'package:docdoc_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kOnBoardView = '/onBoardView';
  static const kSplashView = '/';
  static const kLoginView = '/loginView';
  static const kPaymentMethods = '/paymentMethods';
  static const kAddNewPaymentMethod = '/addPaymentMethod';
  static const kPaymentDetails = '/paymentDetails';
  static const kPersonalizeRecomendation = '/personalRec';
  static const kRecomendation = '/recomendation';
  static const kRecomendationByCategory = '/recomendationByCategory';

  static GoRouter router = GoRouter(
    initialLocation: kPersonalizeRecomendation,
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
            child: BlocProvider(
              create: (context) => PaymentBloc(getIt.get<PaymentRepositry>()),
              child: const AddPaymentMethodView(),
            ),
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
            child: BlocProvider(
              create: (context) => PaymentBloc(getIt.get<PaymentRepositry>()),
              child: const PaymentView(),
            ),
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
        path: kPaymentDetails,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => PaymentBloc(getIt.get<PaymentRepositry>()),
              child: CreditCardDetailsView(
                creditCardEntity: state.extra as CreditCardEntity,
              ),
            ),
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

      //Personalize Recomendation
      GoRoute(
        path: kPersonalizeRecomendation,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create:
                  (context) =>
                      RecomendationBloc(getIt.get<RecomendationRepo>()),
              child: const PresonalizeRecomendationView(),
            ),
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
        path: kRecomendation,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create:
                  (context) =>
                      RecomendationBloc(getIt.get<RecomendationRepo>()),
              child: const RecomendationView(),
            ),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
          );
        },
      ),
      GoRoute(
        path: kRecomendationByCategory,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create:
                  (context) =>
                      RecomendationBloc(getIt.get<RecomendationRepo>()),
              child: RecomendationByCategoryView(
                subCategory: state.extra as String,
              ),
            ),
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
