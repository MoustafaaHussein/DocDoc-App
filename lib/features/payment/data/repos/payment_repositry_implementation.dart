import 'package:dartz/dartz.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/payment_remote_data_source.dart';
import 'package:docdoc_app/features/payment/domain/entites/subscription_product_entity/subscription_products.dart';
import 'package:docdoc_app/features/payment/domain/repos/payment_repositry.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentRepositoryImpl implements PaymentRepositry {
  final PaymentRemoteDataSource remote;

  PaymentRepositoryImpl(this.remote);

  @override
  Future<Either<String, List<SubscriptionPlan>>> getPlans() async {
    try {
      final products = await remote.getProducts();
      return right(
        products.map((p) {
          return SubscriptionPlan(
            id: p.id,
            title: p.title,
            price: p.price,
            description: p.description,
            rawPrice: p.rawPrice,
            currencyCode: p.currencyCode,
          );
        }).toList(),
      );
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<void> buyPlan(String productId) {
    return remote.buy(productId);
  }

  @override
  Stream<PurchaseDetails> get purchaseUpdates =>
      remote.purchaseStream.expand((e) => e);
}
