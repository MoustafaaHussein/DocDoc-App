import 'package:docdoc_app/core/helpers/api_service.dart';
import 'package:docdoc_app/core/helpers/constants.dart';
import 'package:docdoc_app/core/helpers/shared_prefs_helper.dart';
import 'package:docdoc_app/features/recomendation/data/models/personalize_recomendation_model/personalize_recomendation_model.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_category_model/recomendation_by_category_model.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_emoitions_model/recomendation_by_emoitions_model.dart';

abstract class RecomendationRemoteDataSource {
  Future<List<PersonalizeRecomendationModel>> getPersonalizeRecomendation();
  Future<List<RecomendationByCategoryModel>> getRecomendationByCategory({
    required String subCategory,
  });
  Future<String> completeExcercise({
    required int excersiceId,
    required String feedBack,
  });
  Future<List<RecomendationByEmoitionsModel>> getRecomendationsByEmotions({
    required String selectedEmotion,
  });
}

class RecomendationRemoteDataSourceImpl extends RecomendationRemoteDataSource {
  final ApiService apiService;

  RecomendationRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<PersonalizeRecomendationModel>>
  getPersonalizeRecomendation() async {
    final token = SharedPrefsHelper.getString('token');
    var response = await apiService.get(
      endPoint: '/api/recommendation/personalized',
      token: token,
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

  @override
  Future<List<RecomendationByCategoryModel>> getRecomendationByCategory({
    required String subCategory,
  }) async {
    final token = SharedPrefsHelper.getString('token');
    var language = SharedPrefsHelper.getString(Constants.languageKey);
    var response = await apiService.get(
      endPoint:
          '/api/recommendation/by-category/$subCategory?limit=10&language=$language',
      token: token,
    );
    List<dynamic> list = response as List;
    List<RecomendationByCategoryModel> recomendations = [];
    for (var items in list) {
      recomendations.add(RecomendationByCategoryModel.fromJson(items));
    }

    return recomendations;
  }

  @override
  Future<String> completeExcercise({
    required int excersiceId,
    required String feedBack,
  }) async {
    final token = SharedPrefsHelper.getString('token');
    var language = SharedPrefsHelper.getString(Constants.languageKey);
    var response = await apiService.post(
      endPoint: '/api/recommendation/exercises/$excersiceId/complete?$language',
      token: token,
      data: feedBack,
    );
    return response['message'];
  }

  @override
  Future<List<RecomendationByEmoitionsModel>> getRecomendationsByEmotions({
    required String selectedEmotion,
  }) async {
    final token = SharedPrefsHelper.getString('token');
    var language = SharedPrefsHelper.getString(Constants.languageKey);

    var response = await apiService.get(
      endPoint:
          '/api/recommendation/by-emotion/$selectedEmotion?limit=10&$language',
      token: token,
    );
    List<RecomendationByEmoitionsModel> emotionsRecomendations = [];
    List<dynamic> list = response as List;
    for (var items in list) {
      emotionsRecomendations.add(RecomendationByEmoitionsModel.fromJson(items));
    }
    return emotionsRecomendations;
  }
}
