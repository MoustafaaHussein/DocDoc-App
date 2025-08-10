import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:docdoc_app/core/widgets/custom_loading.dart';
import 'package:docdoc_app/core/widgets/customized_error.dart';
import 'package:docdoc_app/features/Login/presentation/views/widgets/customButton.dart';
import 'package:docdoc_app/features/Login/presentation/views/widgets/customTextFormField.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/Cubit/SignUpCubit.dart';
import 'package:docdoc_app/features/SignUP/presentation/data/Cubit/SignUpState.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../data/model/SignUpModel.dart' show SignUpRequestModel;

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  DateTime? selectedDate;
  String? selectedGender;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Sign Up Successful')));
          GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
        } else if (state is SignUpFailure) {
          CustomErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () {
              GoRouter.of(context).pop();
            },
          );
        } else if (state is SignUpLoading) {
          const CustomLoading();
        }
      },
      builder: (context, state) {
        return _buildFormContent(context);
      },
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 30, left: 20),
      child: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text("sign_up".tr(), style: Textstyles.font32White500Weight),
                SizedBox(height: 20.h),

                CustomTextFormField(
                  label: "first_name".tr(),
                  controller: firstNameController,
                  hinttext: "Taher",
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                ),

                CustomTextFormField(
                  label: "last_name".tr(),
                  controller: lastNameController,
                  hinttext: "Farh",
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Last name is required';
                    }
                    return null;
                  },
                ),

                CustomTextFormField(
                  label: "phone_number".tr(),
                  controller: phoneController,
                  hinttext: "+201234567890",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Phone number is required';
                    }
                    if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),

                CustomTextFormField(
                  label: "email_address".tr(),
                  controller: emailController,
                  hinttext: "example@example.com",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),

                CustomTextFormField(
                  label: "password".tr(),
                  controller: passwordController,
                  hinttext: "••••••••",
                  obscureText: true,
                  icon: IconlyLight.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    if (!RegExp(
                      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$',
                    ).hasMatch(value)) {
                      return 'Password must contain letters and numbers';
                    }
                    return null;
                  },
                ),

                CustomTextFormField(
                  label: "confirm_password".tr(),
                  controller: confirmPasswordController,
                  hinttext: "••••••••",
                  obscureText: true,
                  icon: IconlyLight.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 12.h),

                // Text(
                //   "date_of_birth".tr(),
                //   style: Textstyles.font14Grey400Weight,
                // ),
                // SizedBox(height: 8.h),
                // GestureDetector(
                //   onTap: () => _selectDate(context),
                //   child: Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(
                //       vertical: 14.h,
                //       horizontal: 12.w,
                //     ),
                //     decoration: BoxDecoration(
                //       color: const Color(0xFF1E1E1E),
                //       borderRadius: BorderRadius.circular(12.r),
                //     ),
                //     child: Text(
                //       selectedDate != null
                //           ? "${selectedDate!.toLocal()}".split(' ')[0]
                //           : "Select Date",
                //       style: TextStyle(
                //         color:
                //             selectedDate != null
                //                 ? Colors.white
                //                 : const Color(0xFFA2A2A7),
                //         fontSize: 14.sp,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 16.h),
                Text("gender".tr(), style: Textstyles.font14Grey400Weight),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(
                          "male".tr(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: "male".tr(),
                        groupValue: selectedGender,
                        onChanged: (val) {
                          setState(() => selectedGender = val);
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(
                          "female".tr(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: "female".tr(),
                        groupValue: selectedGender,
                        onChanged: (val) {
                          setState(() => selectedGender = val);
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                CusttomButton(
                  text: "sign_up".tr(),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select your date of birth'),
                          ),
                        );
                        return;
                      }
                      if (selectedGender == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select your gender'),
                          ),
                        );
                        return;
                      }

                      final model = SignUpRequestModel(
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                        phoneNumber: phoneController.text.trim(),
                        dateOfBirth: selectedDate!.toUtc().toIso8601String(),

                        gender: selectedGender!,
                      );

                      context.read<SignUpCubit>().userSignUp(model);
                    }
                  },
                ),

                SizedBox(height: 30.h),

                Center(
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kLoginView);
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'i_already_have_an_account'.tr(),
                            style: Textstyles.font14Grey400Weight,
                          ),

                          TextSpan(
                            text: 'sign_in'.tr(),
                            style: Textstyles.font14MainColor500Weight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
