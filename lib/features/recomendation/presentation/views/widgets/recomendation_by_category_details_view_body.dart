import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/helpers/methods.dart';
import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/custom_loading.dart';
import 'package:docdoc_app/core/widgets/customized_error.dart';
import 'package:docdoc_app/core/widgets/ratting_dialog.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_category_model/recomendation_by_category_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/manger/bloc/recomendation_bloc.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/complete_excercise_dialog.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/gif_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RecomendationByCategoryDetailsViewBody extends StatelessWidget {
  RecomendationByCategoryDetailsViewBody({
    super.key,
    required this.recomendations,
    required this.image,
  });
  final RecomendationByCategoryModel recomendations;
  final String image;
  late String feedBack, timeTakenToComplete;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: GifWidget(gifPath: image, isNetwork: false),
                  ),
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
                        color: getDiffcultyLevel(
                          recomendations.difficultyLevel!,
                        ),
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
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 50)),
        SliverToBoxAdapter(
          child: BlocConsumer<RecomendationBloc, RecomendationState>(
            listener: (context, state) {
              if (state is CompleteExcerciseLoading) {
                CustomLoading();
              } else if (state is CompleteExcerciseFailed) {
                CustomErrorWidget(
                  errorMessage: state.errorMessage,
                  onRetry: () {},
                );
              } else if (state is CompleteExcerciseSuccessful) {
                GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  RateExcerciseWidget(
                    buttonText: 'Rate Recomendation',
                    titleText: 'Recomendation Review',
                    textColor: Colors.amberAccent,
                    textIcon: Icons.star,
                    iconColor: Colors.amberAccent,
                    onSubmit: () {},
                  ),
                  SizedBox(height: 40),

                  ExcersiceDialog(
                    buttonText: 'Complete Excersice',
                    titleText: 'Recomendation Review',
                    textColor: Colors.green,
                    textIcon: Icons.check,
                    iconColor: Colors.green,
                    onSubmit: ({String? feedback, String? timeTaken}) {
                      feedBack = feedback!;
                      timeTakenToComplete = timeTaken!;
                      BlocProvider.of<RecomendationBloc>(context).add(
                        CompleteExcerciseEvent(
                          convertDataToRaw(
                            feedBack: feedBack,
                            timeTakenToComplete: timeTakenToComplete,
                          ),
                          recomendations.id!,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class RateExcerciseWidget extends StatelessWidget {
  const RateExcerciseWidget({
    super.key,
    required this.buttonText,
    required this.titleText,
    required this.textColor,
    required this.textIcon,
    this.iconColor,
    required this.onSubmit,
  });
  final String buttonText, titleText;
  final Color textColor;
  final IconData textIcon;
  final Color? iconColor;
  final VoidCallback onSubmit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return RatingDialogWidget(
                  onSubmit: onSubmit,
                  onCancel: () {
                    GoRouter.of(context).pop();
                  },
                  titleText: titleText,
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: AppStyles.styleSemiBold18(
                  context,
                ).copyWith(color: textColor),
              ),
              SizedBox(width: 12),
              Icon(textIcon, color: iconColor ?? Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}
