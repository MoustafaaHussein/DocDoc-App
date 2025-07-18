import 'package:dartz/dartz.dart';
import 'package:docdoc_app/core/errors/failure.dart';
import 'package:docdoc_app/features/recomendation/data/models/personalize_recomendation_model/personalize_recomendation_model.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation/recomendation_by_category_model.dart';

abstract class RecomendationRepo {
  Future<Either<RequestFailure, List<PersonalizeRecomendationModel>>>
  getPersonalizeRecomendation();
  Future<Either<RequestFailure, List<RecomendationByCategoryModel>>>
  getRecomendationByCategory({required String subCategory});
}
