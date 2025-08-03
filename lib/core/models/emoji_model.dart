import 'package:flutter/material.dart';

final List<Map<String, dynamic>> emojiList = [
  {
    'imagePath': 'assets/images/neutral.png',
    'name': 'neutral',
    'color': Colors.grey, // حيادي
  },
  {
    'imagePath': 'assets/images/angry.png',
    'name': 'angry',
    'color': Colors.redAccent, // غضب
  },
  {
    'imagePath': 'assets/images/happiness.png',
    'name': 'happy',
    'color': Colors.amber, // سعادة
  },
  {
    'imagePath': 'assets/images/sad-face.png',
    'name': 'sad',
    'color': Colors.blue, // حزن
  },
  {
    'imagePath': 'assets/images/fear.png',
    'name': 'fear',
    'color': Colors.deepPurple, // خوف
  },
  {
    'imagePath': 'assets/images/disgusted.png',
    'name': 'disgusted',
    'color': Colors.teal, // اشمئزاز
  },
  {
    'imagePath': 'assets/images/anxiety.png',
    'name': 'anxious',
    'color': Colors.orangeAccent, // قلق
  },
  {
    'imagePath': 'assets/images/banicked.png',
    'name': 'panicked',
    'color': Colors.deepOrange, // ذعر
  },
  {
    'imagePath': 'assets/images/bored.png',
    'name': 'bored',
    'color': Colors.brown, // ملل
  },
  {
    'imagePath': 'assets/images/confused.png',
    'name': 'confused',
    'color': Colors.indigoAccent, // ارتباك
  },
  {
    'imagePath': 'assets/images/hopeless.png',
    'name': 'hopeless',
    'color': Colors.black54, // يأس
  },
  {
    'imagePath': 'assets/images/stressed.png',
    'name': 'stressed',
    'color': Colors.pinkAccent, // توتر
  },
  {
    'imagePath': 'assets/images/worried.png',
    'name': 'nervous',
    'color': Colors.lightBlue, // قلق
  },

  // New emotions from your image folder:
  {
    'imagePath': 'assets/images/depression.png',
    'name': 'depression',
    'color': Colors.blueGrey, // اكتئاب
  },
  {
    'imagePath': 'assets/images/frustrated.png',
    'name': 'frustrated',
    'color': Colors.deepOrangeAccent, // محبط
  },
  {
    'imagePath': 'assets/images/tense.png',
    'name': 'tense',
    'color': Colors.red, // متوتر
  },
  {
    'imagePath': 'assets/images/tired.png',
    'name': 'tired',
    'color': Colors.grey, // متعب
  },
  {
    'imagePath': 'assets/images/restless.png',
    'name': 'restless',
    'color': Colors.amberAccent, // قلقان
  },
  {
    'imagePath': 'assets/images/lonley.png',
    'name': 'lonely',
    'color': Colors.cyan, // وحيد
  },
  {
    'imagePath': 'assets/images/resentful.png',
    'name': 'resentful',
    'color': Colors.orange, // ساخط
  },
  {
    'imagePath': 'assets/images/critical.png',
    'name': 'critical',
    'color': Colors.redAccent, // ناقد
  },
  {
    'imagePath': 'assets/images/sluggish.png',
    'name': 'sluggish',
    'color': Colors.tealAccent, // كسول
  },
  {
    'imagePath': 'assets/images/unmotivated.png',
    'name': 'unmotivated',
    'color': Colors.brown, // بلا دافع
  },
  {
    'imagePath': 'assets/images/stiff.png',
    'name': 'stiff',
    'color': Colors.deepPurpleAccent, // متجمد
  },
  {
    'imagePath': 'assets/images/negative.png',
    'name': 'negative',
    'color': Colors.black87, // سلبي
  },
  {
    'imagePath': 'assets/images/ungrateful.png',
    'name': 'ungrateful',
    'color': Colors.grey, // غير ممتن
  },
  {
    'imagePath': 'assets/images/worried.png',
    'name': 'worried',
    'color': Colors.blueGrey, // قلق
  },
];

final Map<String, Map<String, dynamic>> emojiMap = {
  for (var emoji in emojiList) emoji['name']: emoji,
};
