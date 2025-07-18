import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/features/recomendation/data/models/category_model.dart/category_model.dart';
import 'package:flutter/material.dart';

class RecomendationViewBody extends StatelessWidget {
  const RecomendationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: CategoryList()), SizedBox(height: 60)],
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoriesList.length,
      itemBuilder: (context, index) {
        return CategoryListItem(titleText: categoriesList[index].category);
      },
    );
  }
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({super.key, required this.titleText});
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kSubTitleColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        titleText,
        style: AppStyles.styleMedium13(context).copyWith(color: Colors.white),
      ),
    );
  }
}
