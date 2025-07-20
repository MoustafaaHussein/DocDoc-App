import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/features/Home/presentation/views/Home.dart';
import 'package:docdoc_app/features/Home/presentation/views/widgets/test.dart'
    hide HomeScreen;
import 'package:docdoc_app/features/Profile/presentation/views/Profile.dart';
import 'package:flutter/material.dart';

import 'package:flutter_iconly/flutter_iconly.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<IconData> iconList = [IconlyLight.home, IconlyLight.user2];

  final List<Widget> _screens = [HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_bottomNavIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.kButtonPrimaryColor,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.kDarkModeBackgroundColor.withOpacity(0.0),
            borderRadius: BorderRadius.circular(40),
          ),
          child: AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            backgroundColor: const Color.fromARGB(255, 52, 57, 90),
            activeColor: AppColors.kButtonPrimaryColor,
            inactiveColor: Colors.grey,
            onTap: (index) {
              setState(() {
                _bottomNavIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
