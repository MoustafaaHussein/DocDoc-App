import 'package:dio/dio.dart';
import 'package:docdoc_app/features/Mood_History/model/MoodRecorrdModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MoodHistoryRepo {
  final Dio dio;

  MoodHistoryRepo(this.dio);

  Future<MoodHistoryResponse?> getMoodHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return null;

    try {
      final response = await dio.get(
        'https://mood-api-8urg.onrender.com/api/mood/history',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return MoodHistoryResponse.fromJson(response.data);
      }
    } catch (e) {
      print('Error fetching mood history: $e');
    }
    return null;
  }
}
