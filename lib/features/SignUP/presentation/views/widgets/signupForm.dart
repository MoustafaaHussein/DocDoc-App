import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:docdoc_app/features/Login/presentation/views/widgets/customButton.dart';
import 'package:docdoc_app/features/Login/presentation/views/widgets/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final NameController = TextEditingController();
    final PhoneController = TextEditingController();
    final EmailController = TextEditingController();
    final PasswordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text("Sign Up", style: Textstyles.font32White500Weight),
          SizedBox(height: 20.h),

          CustomTextFormField(
            label: "Full Name",
            controller: NameController,
            hinttext: "Tony Abraham",
          ),

          CustomTextFormField(
            label: "Phone Number",
            controller: PhoneController,
            hinttext: "+88520577931",
          ),

          CustomTextFormField(
            label: "Email Address",
            controller: EmailController,
            hinttext: "example@example.com",
          ),

          CustomTextFormField(
            label: "Password",
            controller: PasswordController,
            hinttext: "••••••••",
            obscureText: true,
            icon: IconlyLight.lock,
          ),

          CusttomButton(text: "Sign Up", onTap: () {}),

          SizedBox(height: 16.h),

          Center(
            child: InkWell(
              onTap: () {
                GoRouter.of(context).push(AppRouter.kLoginView);
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'I already have an account. ',
                      style: Textstyles.font14Grey400Weight,
                    ),
                    TextSpan(
                      text: 'Sign In',
                      style: Textstyles.font14MainColor500Weight,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
