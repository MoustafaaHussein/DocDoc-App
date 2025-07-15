import 'package:docdoc_app/features/payment/data/local_data_source/payment_local_data_source.dart';
import 'package:docdoc_app/features/payment/domain/entites/credit_card_entity.dart';
import 'package:docdoc_app/features/payment/domain/repos/payment_repositry.dart';

class PaymentRepositryImplementation implements PaymentRepositry {
  final PaymentLocalDataSource paymentLocalDataSource;

  PaymentRepositryImplementation(this.paymentLocalDataSource);
  @override
  Future<List<CreditCardEntity>> getAllCards() async {
    return await paymentLocalDataSource.getAllCards();
  }

  @override
  Future<void> addNewCreditCard({required CreditCardEntity creditCard}) async {
    await paymentLocalDataSource.addCreditCard(creditCard);
  }
}
