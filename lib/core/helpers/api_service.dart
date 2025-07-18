import 'package:dio/dio.dart';

class ApiService {
  ApiService(this._dio);
  final String _baseURl = 'https://mood-api-8urg.onrender.com';
  final Dio _dio;

  Future<T> get<T>({required String endPoint, String? token}) async {
    Response response = await _dio.get(
      '$_baseURl$endPoint',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? data,
    FormData? formData,
    String? token,
  }) async {
    final payload = formData ?? data;

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',

      if (formData != null) 'Content-Type': 'multipart/form-data',
    };

    final response = await _dio.post(
      '$_baseURl$endPoint',
      data: payload,
      options: Options(headers: headers),
    );

    return response.data;
  }
}
