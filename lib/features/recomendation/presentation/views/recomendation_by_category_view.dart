import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/features/recomendation/data/models/category_model.dart/category_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_by_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecomendationByCategoryView extends StatelessWidget {
  const RecomendationByCategoryView({super.key, required this.subCategory});
  final SubCategoryModel subCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: subCategory.name,
        onTap: () {
          GoRouter.of(context).pop();
        },
      ),
      body: RecomendationByCategoryBloc(subCategory: subCategory),
    );
  }
}
