import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/payment_bloc.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/payment_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsBlocConsumer extends StatefulWidget {
  const PaymentsBlocConsumer({super.key});

  @override
  State<PaymentsBlocConsumer> createState() => _PaymentsBlocConsumerState();
}

class _PaymentsBlocConsumerState extends State<PaymentsBlocConsumer> {
  List<CreditCardEntity> creditCards = [];
  @override
  void initState() {
    BlocProvider.of<PaymentBloc>(context).add(GetAllCreditCardsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is GetAllPaymentMethodsSuccess) {
          creditCards = state.creditCards;
        } else if (state is AddPaymentMethodSuccess ||
            state is DeleteCreditCardSuccess) {
          BlocProvider.of<PaymentBloc>(context).add(GetAllCreditCardsEvent());
        }
      },

      builder: (context, state) {
        return PaymentViewBody(creditCards: creditCards);
      },
    );
  }
}
