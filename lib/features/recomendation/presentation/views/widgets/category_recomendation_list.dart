import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/widgets/empty_data_widget.dart';
import 'package:docdoc_app/features/recomendation/data/models/category_model.dart/category_model.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation/recomendation_by_category_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryRecomendationList extends StatelessWidget {
  const CategoryRecomendationList({
    super.key,
    required this.recomendations,
    required this.subCategory,
  });
  final List<RecomendationByCategoryModel> recomendations;
  final SubCategoryModel subCategory;
  @override
  Widget build(BuildContext context) {
    return recomendations.isEmpty
        ? EmptyDataWidget(
          message: 'No recommendation available right now',
          svgAssetPath: Images.imagesImagesNoData,
        )
        : ListView.builder(
          itemCount: recomendations.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                //TODO very important here
                GoRouter.of(context).push(
                  AppRouter.kRcomendationByCategoryDetailsView,
                  extra: RecomendationImageModel(
                    recomendation: recomendations[index],
                    recomendationImage: subCategory.image,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: RecomendantionCard(
                  titile: recomendations[index].title!,
                  diffucltyLevel: recomendations[index].difficultyLevel!,
                  discreption: recomendations[index].description!,
                  timeRemaining:
                      recomendations[index].estimatedDurationMinutes.toString(),
                  instructions: recomendations[index].instructions!,
                  ratting: recomendations[index].effectivenessRating.toString(),
                ),
              ),
            );
          },
        );
  }
}
