import 'package:dartz/dartz.dart';
import 'package:docdoc_app/core/errors/failure.dart';
import 'package:docdoc_app/features/recomendation/data/models/personalize_recomendation_model/personalize_recomendation_model.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_category_model/recomendation_by_category_model.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_emoitions_model/recomendation_by_emoitions_model.dart';

abstract class RecomendationRepo {
  Future<Either<RequestFailure, List<PersonalizeRecomendationModel>>>
  getPersonalizeRecomendation();
  Future<Either<RequestFailure, List<RecomendationByCategoryModel>>>
  getRecomendationByCategory({required String subCategory});
  Future<Either<RequestFailure, String>> completeExcersice({
    required int excersiceId,
    required String feedBack,
  });
  Future<Either<RequestFailure, List<RecomendationByEmoitionsModel>>>
  getRecomendationsByEmotions({required String selectedEmotion});
}
