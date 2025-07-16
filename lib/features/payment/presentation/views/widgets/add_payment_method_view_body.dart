import 'package:docdoc_app/core/styles/app_text_styles.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/widgets/custom_button.dart';
import 'package:docdoc_app/core/widgets/custom_text_field.dart';
import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/payment_bloc.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_custom_text_field.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/cvc_widget.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/expiry_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddPaymentMethodViewBody extends StatefulWidget {
  const AddPaymentMethodViewBody({super.key});

  @override
  State<AddPaymentMethodViewBody> createState() =>
      _AddPaymentMethodViewBodyState();
}

class _AddPaymentMethodViewBodyState extends State<AddPaymentMethodViewBody> {
  final TextEditingController controller = TextEditingController();

  final FocusNode currentFocus = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();
  String part1 = '';
  String part2 = '';
  String part3 = '';
  String part4 = '';

  final uuid = Uuid();

  late String cardHolderName, cardNumber, cvc, expiryMonth, expiryYear;

  String? cardTypes;

  void updateCardType(String cardNumber) {
    String? type;
    if (cardNumber.startsWith('4')) {
      type = 'Visa';
    } else if (RegExp(
      r'^(5[1-5]|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)',
    ).hasMatch(cardNumber)) {
      type = 'Mastercard';
    } else {
      type = 'Undefined';
    }

    setState(() => cardTypes = type);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                'Card Number',
                style: AppTextStyles.font14Normal.copyWith(
                  fontSize: 16,
                  height: 1,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: CreditCardCustomTextField(
                      onChange: (value) {
                        part1 = value!;
                      },
                    ),
                  ),
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
                  Expanded(
                    child: CreditCardCustomTextField(
                      onChange: (p0) {
                        part2 = p0!;
                      },
                    ),
                  ),
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
                  Expanded(
                    child: CreditCardCustomTextField(
                      onChange: (p0) => part3 = p0!,
                    ),
                  ),
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
                  Expanded(
                    child: CreditCardCustomTextField(
                      onChange: (p0) {
                        part4 = p0!;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Cardholder Name',
                style: AppTextStyles.font14Normal.copyWith(
                  fontSize: 16,
                  height: 1,
                ),
              ),
              SizedBox(height: 15),
              CustomTextField(
                onChange: (value) {
                  cardHolderName = value!;
                },
              ),
              SizedBox(height: 30),
              Text(
                'Expiration Date',
                style: AppTextStyles.font14Normal.copyWith(
                  fontSize: 16,
                  height: 1,
                ),
              ),
              SizedBox(height: 15),
              ExpiryDatePicker(
                onChanged: (month, year) {
                  expiryMonth = month;
                  expiryYear = year;
                },
              ),
              SizedBox(height: 30),
              Text(
                'CVC',
                style: AppTextStyles.font14Normal.copyWith(
                  fontSize: 16,
                  height: 1,
                ),
              ),
              SizedBox(height: 10),
              CVC(
                onChange: (value) {
                  cvc = value!;
                },
              ),
              SizedBox(height: 200),
              CustomButton(
                onpressed: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      cardNumber = part1 + part2 + part3 + part4;
                    });
                    updateCardType(cardNumber);
                    BlocProvider.of<PaymentBloc>(
                      context,
                    ).add(AddNewPaymentMethodEvent(creditCards: toEntity()));
                  }
                },
                text: 'Add Credit Card +',
                buttonColor: AppColors.kButtonPrimaryColor,
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  CreditCardEntity toEntity() {
    return CreditCardEntity(
      id: uuid.v4(),
      nameOnCard: cardHolderName,
      cardNumber: cardNumber,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      cvc: cvc,
      cardType: cardTypes!,
    );
  }
}
