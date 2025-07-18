import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_router/go_router.dart';

class EmojiSwitchScreen extends StatefulWidget {
  const EmojiSwitchScreen({super.key});

  @override
  State<EmojiSwitchScreen> createState() => _EmojiSwitchScreenState();
}

class _EmojiSwitchScreenState extends State<EmojiSwitchScreen> {
  final List<Map<String, dynamic>> emojiList = [
    {
      'imagePath': 'assets/images/neutral.png',
      'name': 'Neutral',
      'color': Colors.blueGrey,
    },
    {
      'imagePath': 'assets/images/angry.png',
      'name': 'Angry',
      'color': Colors.redAccent,
    },
    {
      'imagePath': 'assets/images/happiness.png',
      'name': 'Happy',
      'color': Colors.amber,
    },
    {
      'imagePath': 'assets/images/sad-face.png',
      'name': 'Sad',
      'color': Colors.indigo,
    },
    {
      'imagePath': 'assets/images/fear.png',
      'name': 'Fear',
      'color': Colors.purple,
    },
    {
      'imagePath': 'assets/images/disgusted.png',
      'name': 'Disgusted',
      'color': Colors.green,
    },
  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.7,
      initialPage: _currentPage,
    );

    _pageController.addListener(() {
      int newPage = _pageController.page!.round();
      if (newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color selectedEmojiColor = emojiList[_currentPage]['color'];
    final String selectedEmotionName = emojiList[_currentPage]['name'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectedEmojiColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E2D),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                IconlyLight.arrowLeft2,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                if (GoRouter.of(context).canPop()) {
                  GoRouter.of(context).pop();
                }
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            color: selectedEmojiColor,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: PageView.builder(
                controller: _pageController,
                itemCount: emojiList.length,
                itemBuilder: (context, index) {
                  final bool isSelected = index == _currentPage;
                  final emojiData = emojiList[index];

                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = (1 - (_pageController.page! - index).abs() * 0.25)
                        .clamp(0.0, 1.0);
                  }

                  double imageSize =
                      120.0 * (0.8 + 0.2 * value); // حجم الصورة بدل حجم الخط
                  double imageOpacity = 0.4 + 0.6 * value;

                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double animatedTranslateY = 0;
                      double animatedScale = 1.0;
                      if (_pageController.position.haveDimensions) {
                        double position = _pageController.page! - index;
                        animatedTranslateY =
                            -50 * (1 - position.abs()).clamp(0.0, 1.0);
                        animatedScale = (1 - position.abs() * 0.25).clamp(
                          0.7,
                          1.0,
                        );
                      }

                      return Center(
                        child: Opacity(
                          opacity: imageOpacity, // تطبيق الشفافية على الصورة
                          child: Transform.translate(
                            offset: Offset(0, animatedTranslateY),
                            child: Transform.scale(
                              scale: animatedScale,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // استخدام Image.asset بدلاً من Text لعرض الصورة
                                  Image.asset(
                                    emojiData['imagePath'],
                                    key: ValueKey(
                                      emojiData['imagePath'],
                                    ), // مفتاح فريد للصورة
                                    width: imageSize, // تحديد عرض الصورة
                                    height: imageSize, // تحديد ارتفاع الصورة
                                  ),
                                  // اسم الشعور تحت الصورة
                                  Text(
                                    emojiData['name'],
                                    style: TextStyle(
                                      fontSize: 24 * value,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(
                                        imageOpacity,
                                      ),
                                    ),
                                  ),
                                  // "العصا"
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 200),
                                    opacity: isSelected ? 1.0 : 0.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Container(
                                        width: 15,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.brown[700],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  print('Selected Emotion: $selectedEmotionName');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم اختيار: $selectedEmotionName'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E2D),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Select Emotion',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
