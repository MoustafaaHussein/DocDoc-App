import 'package:animations/animations.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/features/recomendation/data/models/category_model.dart/category_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryGridPage extends StatelessWidget {
  const CategoryGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 12,
        childAspectRatio: 3 / 2,
      ),
      itemCount: categoriesList.length,
      itemBuilder: (context, index) {
        final category = categoriesList[index];
        return OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
          openBuilder: (context, _) => SubCategoryPage(category: category),
          closedElevation: 1,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          closedColor: Colors.transparent,
          closedBuilder: (context, openContainer) {
            return CategoryCard(
              category: category.translatedName,
              onTap: openContainer,
            );
          },
        );
      },
    );
  }
}

// Category card widget
class CategoryCard extends StatelessWidget {
  final String category;
  final VoidCallback onTap;
  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 14, 78, 131),
                Color.fromARGB(255, 10, 35, 55),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              category,
              style: AppStyles.styleSemiBold18(
                context,
              ).copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// Page showing subcategories
class SubCategoryPage extends StatelessWidget {
  final CategoryModel category;
  const SubCategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: category.translatedName,
        onTap: () => GoRouter.of(context).pop(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: category.subCategories.length,
        itemBuilder: (context, index) {
          final sub = category.subCategories[index];
          return GestureDetector(
            onTap: () {
              GoRouter.of(
                context,
              ).push(AppRouter.kRecomendationByCategory, extra: sub);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Text(
                sub.translatedName,
                style: AppStyles.styleMedium18(
                  context,
                ).copyWith(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
