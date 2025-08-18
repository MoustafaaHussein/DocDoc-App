import 'dart:convert';

import 'package:docdoc_app/core/models/emoji_model.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/pro_membership_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

Future<dynamic> managePlansMethod(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true, // makes it take full height if you want
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SizedBox(
        height: 600.h, // adjust to your design
        child: const ProMembershipWidget(),
      );
    },
  );
}
