import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/add_payment_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddPaymentMethodView extends StatelessWidget {
  const AddPaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: 'Add New Card',
        onTap: () {
          GoRouter.of(context).pop();
        },
      ),
      body: AddPaymentBlocConsumer(),
    );
  }
}
