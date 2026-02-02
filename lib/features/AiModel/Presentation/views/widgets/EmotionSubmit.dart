import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmotionSubmitService {
  static Future<bool> submitEmotion({
    required String emotionType,
    required int intensityLevel,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return false;
    }

    try {
      final dio = Dio();

      final response = await dio.post(
        'https://mood-api-8urg.onrender.com/api/mood',
        data: {"emotionType": emotionType, "intensityLevel": intensityLevel},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
