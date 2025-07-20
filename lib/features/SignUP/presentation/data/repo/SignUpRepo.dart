import 'package:dio/dio.dart';
import 'package:docdoc_app/features/Login/Data/Model/LoginModel.dart';
import 'package:docdoc_app/features/Login/Data/Repo/LoginRepo.dart'
    show LoginRequestModel;
import 'package:docdoc_app/features/SignUP/presentation/data/model/SignUpModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Dio dio;
  AuthRepository({required this.dio});
  Future<Map<String, dynamic>> signUp(SignUpRequestModel model) async {
    try {
      print("📤 Request Body: ${model.toJson()}");

      final response = await dio.post(
        "https://mood-api-8urg.onrender.com/api/auth/register",
        data: model.toJson(),
      );

      print("📥 Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? 'Sign Up failed');
      }
    } catch (e) {
      print("❌ DioException: $e");
      rethrow;
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel model) async {
    try {
      final response = await dio.post(
        "https://mood-api-8urg.onrender.com/api/auth/login",
        data: model.toJson(),
      );
      print("📥 Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.data}");

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } catch (e) {
      print("❌ DioException: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  // Future<void> logout(BuildContext context) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('token');

  //   context.go(AppRouter.kLoginView);
  // }
}
