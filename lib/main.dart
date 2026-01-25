import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:docdoc_app/core/helpers/shared_prefs_helper.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/services/in_app_purches_service.dart';
import 'package:docdoc_app/core/services/service_locator.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/Analytics/cubit/AnalyticsCubit.dart';
import 'package:docdoc_app/features/Analytics/repo/AnalyticsRepo.dart';
import 'package:docdoc_app/features/Login/Data/Cubit/LoginCubit.dart';
import 'package:docdoc_app/features/Mood_History/cubit/MoodeHistoryCubit.dart';
import 'package:docdoc_app/features/Mood_History/repo/MoodHistoryRepo.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/Cubit/SignUpCubit.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/repo/SignUpRepo.dart';
import 'package:docdoc_app/features/payment/domain/repos/payment_repo.dart';
import 'package:docdoc_app/features/payment/domain/repos/subscription_repo.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/subcription_bloc.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/subcription_event.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:docdoc_app/features/recomendation/domain/repos/recomendation_repo.dart';
import 'package:docdoc_app/features/recomendation/presentation/manger/bloc/recomendation_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPrefsHelper.init();
  await Purchases.configure(
    PurchasesConfiguration('goog_lUCieNVQuSnYCQXQMsvVWkMTRUc'),
  );
  final token = SharedPrefsHelper.getString("token");
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error accessing cameras: $e');
  }

  final iapService = InAppPurchaseService();
  iapService.initialize();
  await serviceLocator();

  final router = AppRouter.initRouter(isLoggedIn: token != null);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: DocDocApp(router: router),
    ),
  );
}

class DocDocApp extends StatelessWidget {
  const DocDocApp({super.key, required this.router});
  final GoRouter router;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<RecomendationBloc>(
              create:
                  (context) =>
                      RecomendationBloc(getIt.get<RecomendationRepo>()),
            ),
            BlocProvider<SubscriptionCubit>(
              create: (context) => SubscriptionCubit(getIt.get<PaymentRepo>()),
            ),
            BlocProvider<WeeklyMoodCubit>(
              create: (context) => WeeklyMoodCubit(WeeklyMoodRepo(Dio())),
            ),
            BlocProvider<MoodHistoryCubit>(
              create:
                  (context) =>
                      MoodHistoryCubit(context.read<MoodHistoryRepo>()),
            ),
            BlocProvider(create: (_) => LoginCubit(AuthRepository(dio: Dio()))),
            BlocProvider(
              create: (_) => SignUpCubit(AuthRepository(dio: Dio())),
            ),
            BlocProvider(
              create:
                  (context) =>
                      SubscriptionBloc(getIt<SubscriptionRepository>())
                        ..add(const InitializeSubscription()),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            theme: ThemeData.dark().copyWith(
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme,
              ),
              scaffoldBackgroundColor: AppColors.kDarkModeBackgroundColor,
            ),
          ),
        );
      },
    );
  }
}
