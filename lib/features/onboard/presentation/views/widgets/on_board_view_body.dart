import 'package:docdoc_app/core/helpers/constants.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/features/onboard/presentation/views/widgets/on_board_page_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardViewBody extends StatefulWidget {
  const OnBoardViewBody({super.key});

  @override
  State<OnBoardViewBody> createState() => _OnBoardViewBodyState();
}

class _OnBoardViewBodyState extends State<OnBoardViewBody> {
  late PageController pageController;
  var currentPage = 0;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: OnBoardPageView(pageController: pageController)),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.kButtonPadding(context),
          ),
          child: CustomButton(
  onpressed: () async {
    if (currentPage < 2) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTime', false);

      GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
    }
  },
  text: 'التالي',
  buttonColor: AppColors.kButtonPrimaryColor,
),

        ),
        SizedBox(height: 40),
      ],
    );
  }
}
