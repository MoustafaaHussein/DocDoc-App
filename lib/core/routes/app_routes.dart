import 'package:docdoc_app/core/helpers/service_locator.dart';
import 'package:docdoc_app/features/AiModel/Presentation/views/EmotionDetectorScreen.dart';
import 'package:docdoc_app/features/AiSession/presentation/views/Ai_View.dart';
import 'package:docdoc_app/features/Analytics/screens/AnalyticsScreen.dart';
import 'package:docdoc_app/features/Analytics/screens/demo.dart';
import 'package:docdoc_app/features/Home/presentation/views/CustomNavigationBar.dart';
import 'package:docdoc_app/features/Home/presentation/views/Home.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/emojySwitcher.dart';
import 'package:docdoc_app/features/Login/presentation/views/LoginScreen.dart';
import 'package:docdoc_app/features/Mood_History/Screens/MoodHistoryScreen.dart';
import 'package:docdoc_app/features/PersonInformation/presentation/views/PersonInformation.dart';
import 'package:docdoc_app/features/SignUP/presentation/views/SignUP_Screen.dart';
import 'package:docdoc_app/features/onboard/presentation/views/on_board_view.dart';
import 'package:docdoc_app/features/payment/domain/repos/payment_repositry.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:docdoc_app/features/payment/presentation/views/add_payment_method_view.dart';
import 'package:docdoc_app/features/payment/presentation/views/payment_view.dart';
import 'package:docdoc_app/features/recomendation/data/models/category_model.dart/category_model.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_emoitions_model/recomendation_by_emoitions_model.dart';
import 'package:docdoc_app/features/recomendation/domain/repos/recomendation_repo.dart';
import 'package:docdoc_app/features/recomendation/presentation/manger/bloc/recomendation_bloc.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/presonalize_recomendation_view.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/recomendation_by_category_details_view.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/recomendation_by_category_view.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/recomendation_by_emotions_view.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/recomendation_view.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/recomendations_by_emotions_details_view.dart';
import 'package:docdoc_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const kOnBoardView = '/onBoardView';
  static const kHistoryView = '/HistoryView';
  static const kAnalyticsView = '/AnalyticsView';
  static const kDemoView = '/DemoView';
  static const kSplashView = '/';
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
  static const kHomeView = '/HomeView';
  static const kPersonInformationView = '/PersonInformationView';
  static const kHomePage = '/Home';
  static const kRcomendationByCategoryDetailsView = '/RecomendationDetails';
  static const kRecomendationByEmotions = '/RecomenadtionByEmotions';
  static const kRecomendationByEmotionsDetails =
      '/RecomenadtionByEmotionsDetails';

  static GoRouter initRouter({required bool isLoggedIn}) {
    return GoRouter(
      initialLocation: kSplashView,
      //isLoggedIn ? kHomePage : kLoginView,
      routes: [
        GoRoute(
          path: kHistoryView,
          builder: (context, state) => const MoodHistoryScreen(),
        ),
        GoRoute(
          path: kDemoView,
          builder: (context, state) => const WeeklyMoodDemoScreen(),
        ),
        GoRoute(
          path: kAnalyticsView,
          builder: (context, state) => const WeeklyMoodScreen(),
        ),
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

        GoRoute(
          path: kAddNewPaymentMethod,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create:
                      (context) => PaymentCubit(getIt.get<PaymentRepositry>()),
                  child: const AddPaymentMethodView(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
        GoRoute(
          path: kPaymentMethods,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create:
                      (context) => PaymentCubit(getIt.get<PaymentRepositry>()),
                  child: const PaymentView(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),

        // GoRoute(
        //   path: kPaymentDetails,
        //   pageBuilder:
        //       (context, state) => CustomTransitionPage(
        //         child: BlocProvider(
        //           create:
        //               (context) => PaymentCubit(getIt.get<PaymentRepositry>()),
        //           child: CreditCardDetailsView(
        //             creditCardEntity: state.extra as CreditCardEntity,
        //           ),
        //         ),
        //         transitionsBuilder:
        //             (context, animation, secondaryAnimation, child) =>
        //                 FadeTransition(opacity: animation, child: child),
        //       ),
        // ),
        GoRoute(
          path: kPersonalizeRecomendation,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create:
                      (context) =>
                          RecomendationBloc(getIt.get<RecomendationRepo>()),
                  child: const PresonalizeRecomendationView(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
        GoRoute(
          path: kRecomendation,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create:
                      (context) =>
                          RecomendationBloc(getIt.get<RecomendationRepo>()),
                  child: const RecomendationView(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
        GoRoute(
          path: kRecomendationByCategory,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create:
                      (context) =>
                          RecomendationBloc(getIt.get<RecomendationRepo>()),
                  child: RecomendationByCategoryView(
                    subCategory: state.extra as SubCategoryModel,
                  ),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
        GoRoute(
          path: kRcomendationByCategoryDetailsView,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create:
                      (context) =>
                          RecomendationBloc(getIt.get<RecomendationRepo>()),
                  child: RecomendationByCategoryDetailsView(
                    recomendations: state.extra as RecomendationImageModel,
                  ),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
        GoRoute(
          path: kRecomendationByEmotions,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create:
                      (context) =>
                          RecomendationBloc(getIt.get<RecomendationRepo>()),
                  child: RecomendationByEmotionsView(
                    selectedEmotion: state.extra as String,
                  ),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
        GoRoute(
          path: kRecomendationByEmotionsDetails,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: BlocProvider(
                  create:
                      (context) =>
                          RecomendationBloc(getIt.get<RecomendationRepo>()),
                  child: RecomendationsByEmotionsDetailsView(
                    recomendations:
                        state.extra as RecomendationByEmoitionsModel,
                  ),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
        ),
      ],
    );
  }
}
