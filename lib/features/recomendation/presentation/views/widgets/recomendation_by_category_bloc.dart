import 'package:docdoc_app/core/widgets/custom_loading.dart';
import 'package:docdoc_app/core/widgets/customized_error.dart';
import 'package:docdoc_app/features/recomendation/presentation/manger/bloc/recomendation_bloc.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/recomendation_by_category_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecomendationByCategoryBloc extends StatefulWidget {
  const RecomendationByCategoryBloc({super.key, required this.subCategory});
  final String subCategory;

  @override
  State<RecomendationByCategoryBloc> createState() =>
      _RecomendationByCategoryBlocState();
}

class _RecomendationByCategoryBlocState
    extends State<RecomendationByCategoryBloc> {
  @override
  void initState() {
    BlocProvider.of<RecomendationBloc>(
      context,
    ).add(CategoryRecomendationEvent(subCategory: widget.subCategory));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecomendationBloc, RecomendationState>(
      builder: (context, state) {
        if (state is CategoryRecomendationSucess) {
          return RecomendationByCategoryViewBody(
            recomendations: state.recomendations,
          );
        } else if (state is CategoryRecomendationFailed) {
          return CustomErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () {},
          );
        } else {
          return CustomLoading();
        }
      },
    );
  }
}
