class CategoryModel {
  final String category;
  final List<String> subCategory;

  CategoryModel({required this.category, required this.subCategory});
}

final List<CategoryModel> categoriesList = [
  CategoryModel(category: 'Exercise', subCategory: ['physical', 'breathing']),
  CategoryModel(category: 'Meditation', subCategory: ['meditation']),
  CategoryModel(category: 'Mental', subCategory: ['cognitive']),
  CategoryModel(category: 'Social', subCategory: ['social']),
  CategoryModel(category: 'Creative', subCategory: ['creative']),
  CategoryModel(category: 'Self-Care', subCategory: ['self-care']),
  CategoryModel(category: 'Emergency', subCategory: ['emergency']),
  CategoryModel(category: 'Environmental', subCategory: ['nature']),
];
