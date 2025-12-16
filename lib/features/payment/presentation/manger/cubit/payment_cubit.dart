import 'dart:async';

import 'package:docdoc_app/features/payment/domain/repos/payment_repositry.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepositry repository;
  StreamSubscription<dynamic>? _sub;

  PaymentCubit(this.repository) : super(PaymentInitial());

  Future<void> loadPlans() async {
    emit(PaymentLoading());
    try {
      final plans = await repository.getPlans();
      emit(PaymentLoaded(plans)); // Correct state
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> buy(String productId) async {
    emit(PaymentPurchasing());
    try {
      await repository.buyPlan(productId);
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  void listenToPurchases() {
    _sub = repository.purchaseUpdates.listen((purchase) {
      if (purchase.status == PurchaseStatus.purchased) {
        emit(PaymentSuccess());
      } else if (purchase.status == PurchaseStatus.error) {
        emit(PaymentError(purchase.error?.message ?? 'Purchase failed'));
      }
    });
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
