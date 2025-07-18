import 'package:docdoc_app/core/helpers/api_service.dart';
import 'package:docdoc_app/features/recomendation/data/models/personalize_recomendation_model/personalize_recomendation_model.dart';

abstract class RecomendationRemoteDataSource {
  Future<List<PersonalizeRecomendationModel>> getPersonalizeRecomendation();
}

class RecomendationRemoteDataSourceImpl extends RecomendationRemoteDataSource {
  final ApiService apiService;

  RecomendationRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<PersonalizeRecomendationModel>>
  getPersonalizeRecomendation() async {
    var response = await apiService.get(
      endPoint: '/api/recommendation/personalized',
      token:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJtb2FtZW5AZXhhbXBsZS5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTW9hbWVuIEhhc3NhbiIsIkZpcnN0TmFtZSI6Ik1vYW1lbiIsIkxhc3ROYW1lIjoiSGFzc2FuIiwiVXNlcklkIjoiMSIsImV4cCI6MTc1MzQwMTY3NSwiaXNzIjoiTW9vZE1pcnJvckFQSSIsImF1ZCI6Ik1vb2RNaXJyb3JDbGllbnQifQ.us-Cf_C9KW12b2cE1gAqzi4zMJLZ0FnFJ8-X4gTBjX0',
    );
    List<dynamic> list = response as List;
    List<PersonalizeRecomendationModel> personalizeRecomendation = [];
    for (var items in list) {
      personalizeRecomendation.add(
        PersonalizeRecomendationModel.fromJson(items),
      );
    }
    return personalizeRecomendation;
  }
}
