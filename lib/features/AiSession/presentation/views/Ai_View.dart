import 'package:docdoc_app/features/AiSession/presentation/views/widgets/AiIntroPage.dart';
import 'package:flutter/material.dart';

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
