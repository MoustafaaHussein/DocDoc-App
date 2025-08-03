import 'package:docdoc_app/core/widgets/custom_loading.dart';
import 'package:docdoc_app/core/widgets/customized_error.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/payment_bloc.dart';
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
    BlocProvider.of<PaymentBloc>(context).add(GetProPlansEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state is GetProPlansFailed) {
          return CustomErrorWidget(
            errorMessage: state.errorMessage,
            onRetry: () {
              BlocProvider.of<PaymentBloc>(context).add(GetProPlansEvent());
            },
          );
        } else if (state is GetProPlansSuccess) {
          return ProMemberShipBlocConsumer(proPlans: state.proPlans);
        } else {
          return CustomLoading();
        }
      },
    );
  }
}
