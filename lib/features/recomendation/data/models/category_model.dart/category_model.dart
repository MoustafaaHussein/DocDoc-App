import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_category_model/recomendation_by_category_model.dart';
import 'package:easy_localization/easy_localization.dart';

class SubCategoryModel {
  final String key; // English value (used for API)
  final String image;

  SubCategoryModel({required this.key, required this.image});

  String get translatedName => key.tr(); // Used for UI
}

class CategoryModel {
  final String key; // English value (used for API)
  final List<SubCategoryModel> subCategories;

  CategoryModel({required this.key, required this.subCategories});

  String get translatedName => key.tr(); // Used for UI
}

final List<CategoryModel> categoriesList = [
  CategoryModel(
    key: 'exercise',
    subCategories: [
      SubCategoryModel(key: 'physical', image: Images.imagesImagesExcersice),
      SubCategoryModel(
        key: 'breathing',
        image: Images.imagesImagesBreathingOriginal,
      ),
    ],
  ),
  CategoryModel(
    key: 'meditation',
    subCategories: [
      SubCategoryModel(key: 'meditation', image: Images.imagesImagesMeditation),
    ],
  ),
  CategoryModel(
    key: 'mental',
    subCategories: [
      SubCategoryModel(key: 'cognitive', image: Images.imagesImagesThinking),
    ],
  ),
  CategoryModel(
    key: 'social',
    subCategories: [
      SubCategoryModel(key: 'social', image: Images.imagesImagesSocial),
    ],
  ),
  CategoryModel(
    key: 'creative',
    subCategories: [
      SubCategoryModel(key: 'creative', image: Images.imagesImagesCreative),
    ],
  ),
  CategoryModel(
    key: 'self_care',
    subCategories: [
      SubCategoryModel(key: 'self_care', image: Images.imagesImagesSelfCare),
    ],
  ),
  CategoryModel(
    key: 'emergency'.tr(),
    subCategories: [
      SubCategoryModel(key: 'crisis', image: Images.imagesImagesCrisis),
    ],
  ),
  CategoryModel(
    key: 'environmental'.tr(),
    subCategories: [
      SubCategoryModel(key: 'nature', image: Images.imagesImagesBreathing),
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
