import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:docdoc_app/core/helpers/secure_storage.dart';
import 'package:docdoc_app/core/helpers/service_locator.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/Login/Data/Cubit/LoginCubit.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/Cubit/SignUpCubit.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/repo/SignUpRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  // final router = AppRouter.initRouter(isLoggedIn: token != null);
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error accessing cameras: $e');
  }
  await SecureStorage.init();
  serviceLocator();
  runApp(DocDocApp());
}

class DocDocApp extends StatelessWidget {
  const DocDocApp({super.key, String? token});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LoginCubit(AuthRepository(dio: Dio()))),
            BlocProvider(
              create: (_) => SignUpCubit(AuthRepository(dio: Dio())),
            ),
          ],
          child: MaterialApp.router(
            supportedLocales: const [Locale('ar'), Locale('en')],
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            theme: ThemeData.dark().copyWith(
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme,
              ),
              scaffoldBackgroundColor: AppColors.kDarkModeBackgroundColor,
            ),
            debugShowCheckedModeBanner: false,

            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
