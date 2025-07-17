import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/Login/presentation/views/widgets/customButton.dart';
import 'package:docdoc_app/features/Login/presentation/views/widgets/customTextFormField.dart';
import 'package:docdoc_app/features/SignUP/presentation/views/widgets/signupForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final NameController = TextEditingController();
  final PhoneController = TextEditingController();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kDarkModeBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12), // مسافة بسيطة من الطرف
          child: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E2D),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(IconlyLight.arrowLeft2, color: Colors.white, size: 20),
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: SignupForm(),
    );
  }
}
