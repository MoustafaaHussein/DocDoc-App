import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,

      builder: (context) {
        return const DocDocApp();
      },
    ),
  );
}

class DocDocApp extends StatelessWidget {
  const DocDocApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
// This is a simple Flutter application that sets up the main entry point and the root widget.