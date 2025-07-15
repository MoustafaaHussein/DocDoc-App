import 'package:docdoc_app/features/payment/presentation/views/widgets/payment_bloc_consumer.dart';
import 'package:flutter/widgets.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentsBlocConsumer();
  }
}
