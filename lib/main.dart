import 'package:camera/camera.dart';
import 'package:docdoc_app/core/helpers/secure_storage.dart';
import 'package:docdoc_app/core/helpers/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/Analytics/cubit/AnalyticsCubit.dart';
import 'package:docdoc_app/features/Analytics/repo/AnalyticsRepo.dart';
import 'package:docdoc_app/features/Login/Data/Cubit/LoginCubit.dart';
import 'package:docdoc_app/features/Mood_History/cubit/MoodeHistoryCubit.dart';
import 'package:docdoc_app/features/Mood_History/repo/MoodHistoryRepo.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/Cubit/SignUpCubit.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/repo/SignUpRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart'; 

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error accessing cameras: $e');
  }

  await SecureStorage.init();
  serviceLocator();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  final router = AppRouter.initRouter(isLoggedIn: token != null);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: DevicePreview(
        enabled: false,
        builder: (context) => DocDocApp(router: router),
      ),
    ),
  );
}

class DocDocApp extends StatelessWidget {
  final GoRouter router;

  const DocDocApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<WeeklyMoodCubit>(
              create: (context) => WeeklyMoodCubit(WeeklyMoodRepo(Dio())),
            ),
            BlocProvider<MoodHistoryCubit>(
              create: (context) =>
                  MoodHistoryCubit(context.read<MoodHistoryRepo>()),
            ),
            BlocProvider(create: (_) => LoginCubit(AuthRepository(dio: Dio()))),
            BlocProvider(
              create: (_) => SignUpCubit(AuthRepository(dio: Dio())),
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
