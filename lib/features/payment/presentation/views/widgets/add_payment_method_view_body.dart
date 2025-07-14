import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_custom_text_field.dart';
import 'package:flutter/material.dart';

class AddPaymentMethodViewBody extends StatelessWidget {
  AddPaymentMethodViewBody({super.key});
  final TextEditingController controller = TextEditingController();
  final FocusNode currentFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(child: CreditCardCustomTextField()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  height: 12,
                  width: 12,
                  child: Divider(
                    thickness: 3,
                    color: Colors.grey,
                    radius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Expanded(child: CreditCardCustomTextField()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  height: 12,
                  width: 12,
                  child: Divider(
                    thickness: 3,
                    color: Colors.grey,
                    radius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Expanded(child: CreditCardCustomTextField()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: SizedBox(
                    height: 12,
                    width: 12,
                    child: Divider(
                      thickness: 3,
                      color: Colors.grey,
                      radius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Expanded(child: CreditCardCustomTextField()),
            ],
          ),
        ],
      ),
    );
  }
}
