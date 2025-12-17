import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/styles/TextStyles.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/QuoteCard.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/SpecialAppBar.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/custom_excercise_scrollable_widget.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_state.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/payment_plans_page_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;

  @override
  void initState() {
    super.initState();
    getUserName();

    // Start listening to purchases and load plans
    // final cubit = context.read<PaymentCubit>();
    // cubit.loadPlans();
  }

  void getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString("userFirstName") ?? '';
    final lastName = prefs.getString("userLastName") ?? '';
    setState(() {
      username = '$firstName $lastName';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("subscription_successful".tr()),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is PaymentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is PaymentLoaded) {
          PaymentsPlansPageView(proPlans: state.plans);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomHeader(
            userName: username ?? 'User',
            imageUrl: "assets/images/onboard_image1.png",
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "emotion_recognizer".tr(),
                      style: AppStyles.styleSemiBold24(
                        context,
                      ).copyWith(color: Colors.white),
                    ),
                    Text(
                      'ai_features'.tr(),
                      style: AppStyles.styleRegular14(
                        context,
                      ).copyWith(color: const Color(0xFFA2A2A7)),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // 1-on-1 session premium feature
                InkWell(
                  onTap: () {
                    BlocProvider.of<PaymentCubit>(context).loadPlans();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 240, 229, 193),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'one_on_one_sessions'.tr(),
                            style: Textstyles.font22Brown800Weight,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "open_up".tr(),
                            style: Textstyles.font12Brown400Weight,
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "subscribe_now".tr(),
                                style: Textstyles.font16Orange700Weight,
                              ),
                              Image.asset("assets/images/Meetup Icon.png"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                const CustomExcersicesScrollableWidget(),

                SizedBox(height: 15.h),

                QuoteCard(quote: "quote_battle".tr()),
                SizedBox(height: 15.h),

                InkWell(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kEmojiSwitcherView);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 138, 142, 240),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'describe_your_mood'.tr(),
                            style: Textstyles.font22Black800Weight,
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "check_it_now".tr(),
                                style: AppStyles.styleSemiBold18(
                                  context,
                                ).copyWith(color: Colors.white),
                              ),
                              Flexible(
                                child: Image.asset(
                                  "assets/images/MentalHealth.png",
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
