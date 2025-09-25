import 'package:docdoc_app/core/helpers/api_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

abstract class PaymentRemoteDataSource {
  Future<void> configureRevenueCat(String apiKey);
  Future<Offerings?> getOfferings();
  Future<bool> getCustomerInfo();
  Future<PurchaseResult> PurchesPackage(Package package);
}

class PaymentRemoteDataSourceImplementation extends PaymentRemoteDataSource {
  final ApiService apiService;

  PaymentRemoteDataSourceImplementation({required this.apiService});
  @override
  @override
  Future<void> configureRevenueCat(String apiKey) async {
    await Purchases.configure(PurchasesConfiguration(apiKey));
  }

  @override
  Future<Offerings?> getOfferings() async {
    Offerings? offers = await Purchases.getOfferings();

    return offers;
  }

  @override
  Future<bool> getCustomerInfo() async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    bool isPro = customerInfo.entitlements.active.containsKey("pro membership");
    return isPro;
  }

  @override
  Future<PurchaseResult> PurchesPackage(Package package) async {
    PurchaseResult result = await Purchases.purchasePackage(package);
    return result;
  }
}
