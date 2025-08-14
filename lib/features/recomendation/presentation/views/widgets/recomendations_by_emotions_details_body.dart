import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/helpers/methods.dart';
import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:docdoc_app/core/widgets/custom_loading.dart';
import 'package:docdoc_app/core/widgets/customized_error.dart';
import 'package:docdoc_app/features/recomendation/data/models/recomendation_by_emoitions_model/recomendation_by_emoitions_model.dart';
import 'package:docdoc_app/features/recomendation/presentation/manger/bloc/recomendation_bloc.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/complete_excercise_dialog.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/emojis_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RecomendationsByEmotionsDetailsBody extends StatelessWidget {
  RecomendationsByEmotionsDetailsBody({
    super.key,
    required this.recomendations,
  });
  late String feedBack, timeTakenToComplete;
  final RecomendationByEmoitionsModel recomendations;
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
                const SizedBox(height: 30),
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
                    const Spacer(),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 10),
                    Text(
                      recomendations.effectivenessRating.toString(),
                      style: AppStyles.styleMedium13(context),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      Images.imagesImagesTime,
                      fit: BoxFit.scaleDown,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      "${recomendations.estimatedDurationMinutes} min",
                      style: AppStyles.styleMedium13(
                        context,
                      ).copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Do You feel ?'),
                SizedBox(
                  width: double.infinity,
                  child: EmojisList(
                    receivedEmojis: recomendations.targetEmotions!,
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Instruction'),
                const SizedBox(height: 20),
                Text(recomendations.instructions!),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 50)),
        SliverToBoxAdapter(
          child: BlocConsumer<RecomendationBloc, RecomendationState>(
            listener: (context, state) {
              if (state is CompleteExcerciseLoading) {
                const CustomLoading();
              } else if (state is CompleteExcerciseFailed) {
                CustomErrorWidget(
                  errorMessage: state.errorMessage,
                  onRetry: () {},
                );
              } else if (state is CompleteExcerciseSuccessful) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Thank you For your feedback'.tr(),
                      style: AppStyles.styleMedium16(context),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                GoRouter.of(context).pop();
              }
            },
            builder: (context, state) {
              return Column(
                children: [
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
