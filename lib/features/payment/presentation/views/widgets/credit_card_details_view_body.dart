// File: lib/features/payment/presentation/views/widgets/credit_card_details_view_body.dart

import 'package:docdoc_app/core/helpers/assets.dart';
import 'package:docdoc_app/core/themes/app_colors.dart';
import 'package:docdoc_app/core/widgets/warning_dialog.dart';
import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/payment_bloc.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/card_holder_display.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/card_number_dsiplay.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/credit_card_model.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/cvc_display.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/expiry_date_display.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Required for BlocProvider.of
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// A StatelessWidget that represents the main body content for displaying
/// credit card details. It includes the credit card visual model and
/// action buttons for editing and deleting the card.
class CreditCardDetailsViewBody extends StatelessWidget {
  const CreditCardDetailsViewBody({super.key, required this.creditCardDetails});

  /// The credit card entity whose details are to be displayed.
  final CreditCardEntity creditCardDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displays the credit card visual model
            CreditCardModel(
              creditCardNumber: creditCardDetails.cardNumber,
              cvc: creditCardDetails.cvc,
              expiryMonth: creditCardDetails.expiryMonth,
              expiryYear: creditCardDetails.expiryYear,
              cardType: creditCardDetails.cardType,
              cardHolderName: creditCardDetails.nameOnCard,
            ),

            const SizedBox(height: 30),
            // Displays the card holder's name
            CardHolderNameDisplay(cardHolderName: creditCardDetails.nameOnCard),
            const SizedBox(height: 30),
            // Row for expiry date and CVC display
            Row(
              children: [
                Expanded(
                  child: ExpiryDateDisplay(
                    expiryMonth: creditCardDetails.expiryMonth,
                    expiryYear: creditCardDetails.expiryYear,
                  ),
                ),
                const Spacer(),
                Expanded(child: CvcDisplay(cvc: creditCardDetails.cvc)),
              ],
            ),
            const SizedBox(height: 30),
            // Displays the card number
            CardNumber(
              cardNumber: creditCardDetails.cardNumber,
              cardType: creditCardDetails.cardType,
            ),
            // Spacer to push content to the top
            const Expanded(child: SizedBox()),

            // Action buttons (Delete and Edit)
            Row(
              children: [
                // Delete Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.kDarkModeBackgroundColor,
                  ),
                  onPressed: () {
                    // Show a warning dialog before deleting
                    showDialog(
                      context:
                          context, // Use the context of CreditCardDetailsViewBody
                      builder: (dialogContext) {
                        // This 'dialogContext' is for the dialog's subtree
                        // IMPORTANT FIX:
                        // REMOVE THE BlocProvider HERE.
                        // The PaymentBloc is already provided by the BlocListener in CreditCardDetailsView
                        return WarningDialog(
                          onSubmit: () {
                            // Dispatch the DeleteCreditCardEvent using the existing Bloc.
                            // 'context' here refers to the context of CreditCardDetailsViewBody,
                            // which is a descendant of the BlocListener in CreditCardDetailsView,
                            // so it can correctly find the PaymentBloc.
                            BlocProvider.of<PaymentBloc>(context).add(
                              DeleteCreditCardEvent(
                                cardId: creditCardDetails.id,
                              ),
                            );
                            // Pop the warning dialog immediately after dispatching the event.
                            // The navigation to kPaymentMethods will be handled by the BlocListener
                            // in CreditCardDetailsView once the DeleteCreditCardSuccess state is emitted.
                            GoRouter.of(dialogContext).pop();
                          },
                          titileText:
                              'delete_payment_method'.tr(),
                          subTittle: '',
                          onCancel: () {
                            // Pop the warning dialog if cancelled
                            GoRouter.of(dialogContext).pop();
                          },
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    Images.imagesImagesDeleteTrash,
                    height: 30,
                    width: 30,
                  ),
                ),
                const Spacer(),
                // Edit Button (currently no action)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.kDarkModeBackgroundColor,
                  ),
                  onPressed: () {
                    // TODO: Implement edit functionality
                  },
                  child: SvgPicture.asset(
                    Images.imagesImagesEditPen,
                    height: 30,
                    width: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
