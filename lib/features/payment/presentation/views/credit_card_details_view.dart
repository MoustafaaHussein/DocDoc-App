import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/core/widgets/custom_app_bar.dart';
import 'package:docdoc_app/core/widgets/successfull_dialog.dart';
import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/payment_bloc.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreditCardDetailsView extends StatelessWidget {
  const CreditCardDetailsView({super.key, required this.creditCardEntity});
  final CreditCardEntity creditCardEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        title: 'Card Details',
        onTap: () {
          GoRouter.of(context).pop();
        },
      ),
      body: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is DeleteCreditCardSuccess) {
            showDialog(
              context: context,
              builder:
                  (context) => SuccessDialogWidget(
                    onSubmit: () {
                      GoRouter.of(
                        context,
                      ).pushReplacement(AppRouter.kPaymentMethods);
                      GoRouter.of(context).pop();
                    },
                    titileText: 'Card Deleted Successfully',
                    subTittle: '',
                  ),
            );
          }
        },
        child: CreditCardDetailsViewBody(creditCardDetails: creditCardEntity),
      ),
    );
  }
}
