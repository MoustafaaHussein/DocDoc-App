import 'package:docdoc_app/features/recomendation/data/models/category_model.dart/category_model.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation/recomendation_by_category_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/category_recomendation_list.dart';
import 'package:flutter/material.dart';

class RecomendationByCategoryViewBody extends StatelessWidget {
  const RecomendationByCategoryViewBody({
    super.key,
    required this.recomendations,
    required this.subCategory,
  });
  final List<RecomendationByCategoryModel> recomendations;
  final SubCategoryModel subCategory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
            child: CategoryRecomendationList(
              recomendations: recomendations,
              subCategory: subCategory,
            ),
          ),
        ],
      ),
    );
  }
}
