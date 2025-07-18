import 'package:camera/camera.dart';
import 'package:docdoc_app/core/helpers/secure_storage.dart';
import 'package:docdoc_app/core/helpers/service_locator.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error accessing cameras: $e');
  }
  await SecureStorage.init();
  serviceLocator();
  runApp(const DocDocApp());
}

class DocDocApp extends StatelessWidget {
  const DocDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          supportedLocales: const [Locale('ar'), Locale('en')],
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          theme: ThemeData.dark().copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
            scaffoldBackgroundColor: AppColors.kDarkModeBackgroundColor,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
