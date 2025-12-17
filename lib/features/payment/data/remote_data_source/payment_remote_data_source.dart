import 'package:in_app_purchase/in_app_purchase.dart';

abstract class PaymentRemoteDataSource {
  Future<List<ProductDetails>> getProducts();
  Future<void> buy(String productId);
  Stream<List<PurchaseDetails>> get purchaseStream;
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final InAppPurchase _iap = InAppPurchase.instance;

  static const Set<String> _productIds = {
    'mymood_32_99_1Y',
    'mymood_15_99_6M',
    'mymood_2_99_1M',
  };

  @override
  Future<List<ProductDetails>> getProducts() async {
    final response = await _iap.queryProductDetails(_productIds);

    return response.productDetails;
  }

  @override
  Future<void> buy(String productId) async {
    final response = await _iap.queryProductDetails({productId});

    final product = response.productDetails.first;

    final param = PurchaseParam(productDetails: product);

    await _iap.buyNonConsumable(purchaseParam: param);
  }

  @override
  Stream<List<PurchaseDetails>> get purchaseStream => _iap.purchaseStream;
}
