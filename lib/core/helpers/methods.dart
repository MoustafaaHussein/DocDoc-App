import 'dart:convert';

import 'package:docdoc_app/core/models/emoji_model.dart';
import 'package:flutter/material.dart';

Color getDiffcultyLevel(String level) {
  if (level == 'Easy') {
    return Colors.green;
  } else if (level == 'Medium') {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

Map<String, dynamic> convertToMap(String feedBack, String timeTaken) {
  return {'feedBack': feedBack, "durationMinutes": timeTaken};
}

String convertMapToJson(Map<String, dynamic> data) {
  return jsonEncode(data);
}

List<Map<String, dynamic>?> convertToEmojiDetails(List<String> names) {
  for (final name in names) {
    print('$name => ${emojiMap[name]}');
  }
  return names
      .map((name) => emojiMap[name]) // `name` is already lowercase
      .where((emoji) => emoji != null) // skip unknown ones
      .toList();
}

String convertDataToRaw({
  required String feedBack,
  required String timeTakenToComplete,
}) {
  final String rawData = convertMapToJson(
    convertToMap(feedBack, timeTakenToComplete),
  );
  return rawData;
}
