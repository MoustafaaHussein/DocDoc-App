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
