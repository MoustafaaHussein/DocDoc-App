import 'package:docdoc_app/core/helpers/service_locator.dart';
import 'package:docdoc_app/features/AiModel/Presentation/views/EmotionDetectorScreen.dart';
import 'package:docdoc_app/features/AiSession/presentation/views/Ai_View.dart';
import 'package:docdoc_app/features/Home/presentation/views/CustomNavigationBar.dart';
import 'package:docdoc_app/features/Home/presentation/views/Home.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/emojySwitcher.dart';
import 'package:docdoc_app/features/Login/presentation/views/LoginScreen.dart';
import 'package:docdoc_app/features/PersonInformation/presentation/views/PersonInformation.dart';
import 'package:docdoc_app/features/SignUP/presentation/views/SignUP_Screen.dart';
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
  static const kSplashView = '/ss';
  static const kAiSessionView = '/AiSessionView';
  static const kEmotiomDetectorView = '/EmotiomDetectorView';
  static const kLoginView = '/loginView';
  static const kPaymentMethods = '/paymentMethods';
  static const kAddNewPaymentMethod = '/addPaymentMethod';
  static const kPaymentDetails = '/paymentDetails';
  static const kPersonalizeRecomendation = '/personalRec';
  static const kRecomendation = '/recomendation';
  static const kRecomendationByCategory = '/recomendationByCategory';
  static const kEmojiSwitcherView = '/EmojiSwitcherView';
  static const kSignUpView = '/SignUpView';
  static const kHomeView = '/homeView';
  static const kPersonInformationView = '/PersonInformationView';
  static const kHomePage = '/';

  static GoRouter router = GoRouter(
    initialLocation: kSplashView,
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
      GoRoute(path: kHomeView, builder: (context, state) => const HomeScreen()),
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
