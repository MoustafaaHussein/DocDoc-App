import 'package:bloc/bloc.dart';
import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';
import 'package:docdoc_app/features/payment/domain/repos/payment_repositry.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepositry paymentRepositry;
  PaymentBloc(this.paymentRepositry) : super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) async {
      if (event is AddNewPaymentMethodEvent) {
        await paymentRepositry.addNewCreditCard(creditCard: event.creditCards);
        emit(AddPaymentMethodSuccess());
      }
      if (event is GetAllCreditCardsEvent) {
        emit(GetAllPaymentMethodLoading());
        var creditCards = await paymentRepositry.getAllCards();
        emit(GetAllPaymentMethodsSuccess(creditCards));
      }
      if (event is DeleteCreditCardEvent) {
        await paymentRepositry.deleteCreditCard(cardId: event.cardId);
        emit(DeleteCreditCardSuccess());
      }
    });
  }
}
