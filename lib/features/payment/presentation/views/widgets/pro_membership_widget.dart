import 'package:docdoc_app/core/widgets/custom_loading.dart';
import 'package:docdoc_app/core/widgets/customized_error.dart';
import 'package:docdoc_app/features/payment/presentation/manger/offering_cubit/offering_cubit.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/pro_membership_main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProMembershipWidget extends StatefulWidget {
  const ProMembershipWidget({super.key});

  @override
  State<ProMembershipWidget> createState() => _ProMembershipWidgetState();
}

class _ProMembershipWidgetState extends State<ProMembershipWidget> {
  @override
  void initState() {
    BlocProvider.of<OfferingCubit>(context).fetchOfferings();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferingCubit, OfferingState>(
      builder: (context, state) {
        if (state is OfferingError) {
          return CustomErrorWidget(
            errorMessage: state.message,
            onRetry: () {
              BlocProvider.of<OfferingCubit>(context).fetchOfferings();
            },
          );
        } else if (state is OfferingLoaded) {
          return ProMemberShipBlocConsumer(proPlans: state.package);
        } else {
          return const CustomLoading();
        }
      },
    );
  }
}
