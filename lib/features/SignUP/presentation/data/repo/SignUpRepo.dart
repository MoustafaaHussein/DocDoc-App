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
      final response = await dio.post(
        "https://mood-api-8urg.onrender.com/api/auth/register",
        data: model.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(response.data['message'] ?? 'Sign Up failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel model) async {
    try {
      final response = await dio.post(
        "https://mood-api-8urg.onrender.com/api/auth/login",
        data: model.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");
    await prefs.remove("userId");
    await prefs.remove("userFirstName");
    await prefs.remove("userLastName");
    await prefs.remove("userEmail");
    await prefs.remove("userPhone");
    await prefs.remove("userDob");
    await prefs.remove("userGender");
    await prefs.remove("profilePicture");

    await prefs.setBool("isLoggedIn", false);
  }

  // Future<void> logout(BuildContext context) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('token');

  //   context.go(AppRouter.kLoginView);
  // }
}
