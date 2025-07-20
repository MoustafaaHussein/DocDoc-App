import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/helpers/methods.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/ratting_dialog.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation/recomendation_by_category_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/gif_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RecomendationByCategoryDetailsViewBody extends StatelessWidget {
  const RecomendationByCategoryDetailsViewBody({
    super.key,
    required this.recomendations,
    required this.image,
  });
  final RecomendationByCategoryModel recomendations;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: GifWidget(gifPath: image, isNetwork: false),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  recomendations.title!,
                  style: AppStyles.styleMedium18(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),
              Spacer(),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: getDiffcultyLevel(recomendations.difficultyLevel!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  recomendations.difficultyLevel!,
                  style: AppStyles.styleMedium13(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              softWrap: true,
              maxLines: 2,
              recomendations.description!,
              style: AppStyles.styleMedium16(
                context,
              ).copyWith(color: Colors.grey),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber),
              SizedBox(width: 10),
              Text(
                recomendations.effectivenessRating.toString(),
                style: AppStyles.styleMedium13(context),
              ),
              Spacer(),
              SvgPicture.asset(
                Images.imagesImagesTime,
                fit: BoxFit.scaleDown,
                height: 20,
                width: 20,
              ),
              SizedBox(width: 2),
              Text(
                "${recomendations.estimatedDurationMinutes} min",
                style: AppStyles.styleMedium13(
                  context,
                ).copyWith(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Instruction'),
          SizedBox(height: 20),
          Text(recomendations.instructions!),
          Spacer(),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return RatingDialogWidget(
                    onSubmit: () {
                      GoRouter.of(context).pushNamed(AppRouter.kHomeView);
                    },
                    onCancel: () {
                      GoRouter.of(context).pop();
                    },
                    titleText: 'Rate Excercise',
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rate Excercie',
                  style: AppStyles.styleSemiBold18(
                    context,
                  ).copyWith(color: Colors.amber),
                ),
                SizedBox(width: 12),
                Icon(Icons.star, color: Colors.amber),
              ],
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
