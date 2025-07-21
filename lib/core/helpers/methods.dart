import 'dart:convert';

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
