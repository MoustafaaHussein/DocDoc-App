import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/core/widgets/custom_loading.dart';
import 'package:docdoc_app/core/widgets/customized_error.dart';
import 'package:docdoc_app/features/recomendation/presentation/manger/bloc/recomendation_bloc.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_by_emotions_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecomendationByEmotionsView extends StatefulWidget {
  const RecomendationByEmotionsView({super.key, required this.selectedEmotion});
  final String selectedEmotion;
  @override
  State<RecomendationByEmotionsView> createState() =>
      _RecomendationByEmotionsViewState();
}

class _RecomendationByEmotionsViewState
    extends State<RecomendationByEmotionsView> {
  @override
  void initState() {
    BlocProvider.of<RecomendationBloc>(
      context,
    ).add(GetRecomendationByEmotion(selectedEmotion: widget.selectedEmotion));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: "How are you feeling?",
        onTap: () {
          GoRouter.of(context).pop();
        },
      ),
      body: BlocBuilder<RecomendationBloc, RecomendationState>(
        builder: (context, state) {
          if (state is GetRecomendationBySelectedEmotionFailed) {
            return CustomErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () {
                BlocProvider.of<RecomendationBloc>(context).add(
                  GetRecomendationByEmotion(
                    selectedEmotion: widget.selectedEmotion,
                  ),
                );
              },
            );
          } else if (state is GetRecomendationBySelectedEmotionLoaded) {
            return RecomendationByEmotionsViewBody(
              recomendations: state.emotionsRecomendations,
            );
          } else {
            return const CustomLoading();
          }
        },
      ),
    );
  }
}
