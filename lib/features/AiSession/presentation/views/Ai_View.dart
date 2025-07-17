import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/AiSession/presentation/views/widgets/AiIntroPage.dart';
import 'package:docdoc_app/features/AiSession/presentation/views/widgets/AiSessionHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AiView extends StatefulWidget {
  const AiView({super.key});

  @override
  State<AiView> createState() => _AiViewState();
}

class _AiViewState extends State<AiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AiIntroWidget());
  }
}
