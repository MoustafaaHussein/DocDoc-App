import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation/recomendation_by_category_model.dart';

class SubCategoryModel {
  final String name;
  final String image;

  SubCategoryModel({required this.name, required this.image});
}

class CategoryModel {
  final String category;
  final List<SubCategoryModel> subCategories;

  CategoryModel({required this.category, required this.subCategories});
}

final List<CategoryModel> categoriesList = [
  CategoryModel(
    category: 'Exercise',
    subCategories: [
      SubCategoryModel(name: 'physical', image: Images.imagesImagesExcersice),
      SubCategoryModel(
        name: 'breathing',
        image: Images.imagesImagesBreathingOriginal,
      ),
    ],
  ),
  CategoryModel(
    category: 'Meditation',
    subCategories: [
      SubCategoryModel(
        name: 'meditation',
        image: Images.imagesImagesMeditation,
      ),
    ],
  ),
  CategoryModel(
    category: 'Mental',
    subCategories: [
      SubCategoryModel(name: 'cognitive', image: Images.imagesImagesThinking),
    ],
  ),
  CategoryModel(
    category: 'Social',
    subCategories: [
      SubCategoryModel(name: 'social', image: Images.imagesImagesSocial),
    ],
  ),
  CategoryModel(
    category: 'Creative',
    subCategories: [
      SubCategoryModel(name: 'creative', image: Images.imagesImagesCreative),
    ],
  ),
  CategoryModel(
    category: 'Self-Care',
    subCategories: [
      SubCategoryModel(name: 'self-care', image: Images.imagesImagesSelfCare),
    ],
  ),
  CategoryModel(
    category: 'Emergency',
    subCategories: [
      SubCategoryModel(name: 'crisis', image: Images.imagesImagesCrisis),
    ],
  ),
  CategoryModel(
    category: 'Environmental',
    subCategories: [
      SubCategoryModel(name: 'nature', image: Images.imagesImagesBreathing),
    ],
  ),
];

class RecomendationImageModel {
  final RecomendationByCategoryModel recomendation;
  final String recomendationImage;

  RecomendationImageModel({
    required this.recomendation,
    required this.recomendationImage,
  });
}
