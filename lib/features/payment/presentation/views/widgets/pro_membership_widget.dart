import 'package:docdoc_app/core/widgets/custom_loading.dart';
import 'package:docdoc_app/core/widgets/customized_error.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_state.dart';
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
    BlocProvider.of<PaymentCubit>(context).loadPlans();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state is PaymentError) {
          return CustomErrorWidget(
            errorMessage: state.message,
            onRetry: () {
              BlocProvider.of<PaymentCubit>(context).loadPlans();
            },
          );
        } else if (state is PaymentLoaded) {
          return ProMemberShipBlocConsumer(proPlans: state.plans);
        } else {
          return const CustomLoading();
        }
      },
    );
  }
}
