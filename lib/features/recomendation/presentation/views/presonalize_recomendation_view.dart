import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/core/widgets/custom_loading.dart';
import 'package:docdoc_app/core/widgets/customized_error.dart';
import 'package:docdoc_app/features/recomendation/presentation/manger/bloc/recomendation_bloc.dart';
import 'package:docdoc_app/features/recomendation/presentation/views/widgets/presonalize_recomendation_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PresonalizeRecomendationView extends StatelessWidget {
  const PresonalizeRecomendationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: 'Recomendation',
        onTap: () {
          GoRouter.of(context).push(AppRouter.kRecomendation);
        },
      ),
      body: PersonalizeRecomendationBlocConsumer(),
    );
  }
}

class PersonalizeRecomendationBlocConsumer extends StatefulWidget {
  const PersonalizeRecomendationBlocConsumer({super.key});

  @override
  State<PersonalizeRecomendationBlocConsumer> createState() =>
      _PersonalizeRecomendationBlocConsumerState();
}

class _PersonalizeRecomendationBlocConsumerState
    extends State<PersonalizeRecomendationBlocConsumer> {
  @override
  void initState() {
    BlocProvider.of<RecomendationBloc>(
      context,
    ).add(PersonalizeRecomendationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecomendationBloc, RecomendationState>(
      builder: (context, state) {
        if (state is PersonalizeRecomendationSucess) {
          return PresonalizeRecomendationViewBody(
            personalizeSuggestions: state.recomendations,
          );
        } else if (state is PersonalizeRecomendationFailed) {
          return CustomErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () {
              BlocProvider.of<RecomendationBloc>(
                context,
              ).add(PersonalizeRecomendationEvent());
            },
          );
        } else {
          return CustomLoading();
        }
      },
    );
  }
}
