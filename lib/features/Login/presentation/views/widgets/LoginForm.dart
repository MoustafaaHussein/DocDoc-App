import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/features/Login/Data/Cubit/LoginCubit.dart';
import 'package:docdoc_app/features/Login/Data/Cubit/LoginState.dart';
import 'package:docdoc_app/features/Login/Data/Repo/LoginRepo.dart';
import 'package:docdoc_app/features/Login/presentation/views/widgets/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          final token = state.loginData.token;

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token);

          GoRouter.of(context).go(AppRouter.kHomePage);
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("خطأ في تسجيل الدخول"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 150.h),
              Text("Sign In", style: Textstyles.font32White500Weight),
              SizedBox(height: 40.h),

              CustomTextFormField(
                label: "Email Address",
                controller: emailController,
                hinttext: 'example@example.com',
              ),
              SizedBox(height: 25.h),
              CustomTextFormField(
                label: "Password",
                controller: passwordController,
                hinttext: "••••••••",
                obscureText: true,
                icon: IconlyLight.lock,
              ),
              SizedBox(height: 25.h),

              state is LoginLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                    onpressed: () {
                      final cubit = context.read<LoginCubit>();

                      final model = LoginRequestModel(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      cubit.login(
                        model,
                        "",
                      ); // لو login بياخد model بس شيل الـ ""
                    },
                    text: "Sign In",
                    buttonColor: AppColors.kButtonPrimaryColor,
                  ),

              SizedBox(height: 25.h),
              Center(
                child: InkWell(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kSignUpView);
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'I’m a new user. ',
                          style: Textstyles.font14Grey400Weight,
                        ),
                        TextSpan(
                          text: 'Sign UP',
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
      },
    );
  }
}
