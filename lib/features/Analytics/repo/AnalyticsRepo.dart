import 'package:dio/dio.dart';
import 'package:docdoc_app/features/Analytics/model/AnalyticsModel.dart';

import 'package:shared_preferences/shared_preferences.dart';

class WeeklyMoodRepo {
  final Dio dio;

  WeeklyMoodRepo(this.dio);

  Future<WeeklyMoodModel> fetchWeeklyMoodAnalysis() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("Missing token. Please login again.");
    }

    final response = await dio.get(
      "https://mood-api-8urg.onrender.com/api/analytics/weekly",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    final responseData = response.data;
    
    if (response.statusCode == 200 &&
        responseData['success'] == true &&
        responseData['data'] != null) {
      return WeeklyMoodModel.fromJson(responseData['data']);
    } else {
      throw Exception("Invalid response from server");
    }
  } catch (e) {
    print("❌ Error in WeeklyMoodRepo: $e");
    throw Exception("Something went wrong while fetching weekly mood data");
  }
}

}
