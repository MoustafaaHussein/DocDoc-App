import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MoodScrollSection extends StatefulWidget {
  const MoodScrollSection({super.key});

  @override
  State<MoodScrollSection> createState() => _MoodScrollSectionState();
}

class _MoodScrollSectionState extends State<MoodScrollSection> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentIndex = 0;

  final List<List<double>> _barHeightsList = [
    [8, 16, 36, 29, 52, 91, 64, 41, 31, 8, 8, 8],
    [20, 32, 44, 60, 45, 70, 40, 30, 10, 12, 18, 15],
  ];

  final List<List<Color>> _barColorsList = [
    List.generate(
      12,
      (i) => i < 3 || i > 8 ? const Color(0xFFFEAE8F) : const Color(0xFFFEEFEA),
    ),
    List.generate(
      12,
      (i) => i % 2 == 0 ? const Color(0xFFB2D6A0) : const Color(0xFFE8F4DA),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 320.w,
          height: 230.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 2,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        index == 0
                            ? const Color(0xFFFE804B)
                            : const Color(0xFF9BB068),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: index == 0 ? _buildMoodCard() : _buildScoreCard(),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        SmoothPageIndicator(
          controller: _pageController,
          count: 2,
          effect: WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            spacing: 12,
            activeDotColor: Colors.teal,
            dotColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildMoodCard() {
    final bars = _barHeightsList[0];
    final colors = _barColorsList[0];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.h),
            const Text(
              'Mood',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Urbanist',
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        const Text(
          'Sad',
          style: TextStyle(
            color: Color(0xFFF2F4EA),
            fontSize: 24,
            fontWeight: FontWeight.w800,
            fontFamily: 'Urbanist',
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              bars.length,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.5),
                child: Container(
                  width: 8,
                  height: bars[i],
                  decoration: BoxDecoration(
                    color: colors[i],
                    borderRadius: BorderRadius.circular(1234),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.health_and_safety, color: Colors.white, size: 24),
            SizedBox(width: 8.h),
            Text(
              'Freud Score',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFFB4C38C), width: 10),
          ),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '80',
                  style: TextStyle(
                    color: Color(0xFFF2F4EA),
                    fontSize: 24,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Healthy',
                  style: TextStyle(
                    color: Color(0xFFE5EAD6),
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
