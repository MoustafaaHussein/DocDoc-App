import 'package:docdoc_app/core/helpers/secure_storage.dart';
import 'package:docdoc_app/core/helpers/service_locator.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecureStorage.init();
  serviceLocator();
  runApp(const DocDocApp());
}

class DocDocApp extends StatelessWidget {
  const DocDocApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
  }
}
// This is a simple Flutter application that sets up the main entry point and the root widget.