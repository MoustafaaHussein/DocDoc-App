import 'dart:async';

import 'package:docdoc_app/features/payment/domain/repos/payment_repo.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final PaymentRepo _repository;
  StreamSubscription<bool>? _statusSubscription;

  SubscriptionCubit(this._repository) : super(SubscriptionInitial());

  Future<void> initialize() async {
    emit(SubscriptionLoading());

    try {
      // Listen to subscription status stream
      _statusSubscription = _repository.subscriptionStatus().listen((isActive) {
        if (isActive) {
          emit(SubscriptionSuccess()); // ✅ Show success screen first

          // Wait 2 seconds, then go to Active
          Future.delayed(const Duration(seconds: 2), () {
            if (!isClosed) {
              emit(SubscriptionActive());
            }
          });
        }
      });

      // Check current subscription status
      await checkSubscription();
    } catch (e) {
      emit(SubscriptionError('Failed to initialize: ${e.toString()}'));
    }
  }

  Future<void> onPremiumFeatureRequested() async {
    emit(SubscriptionLoading());

    try {
      final result = await _repository.isUserSubscribed();

      result.fold((failure) => emit(SubscriptionError(failure.message)), (
        isSubscribed,
      ) {
        if (isSubscribed) {
          emit(SubscriptionPremiumAccessGranted());
        } else {
          emit(SubscriptionPremiumAccessDenied());
        }
      });
    } catch (e) {
      emit(SubscriptionError('Failed to check subscription'));
    }
  }

  Future<void> loadProducts() async {
    emit(SubscriptionLoading());

    try {
      final result = await _repository.loadProducts();

      result.fold((failure) => emit(SubscriptionError(failure.message)), (
        products,
      ) {
        if (products.isEmpty) {
          emit(SubscriptionError('No products available'));
        } else {
          emit(ProductsLoaded(products));
        }
      });
    } catch (e) {
      emit(SubscriptionError('Failed to load products: ${e.toString()}'));
    }
  }

  Future<void> buySubscription(ProductDetails product) async {
    emit(SubscriptionLoading());

    try {
      final result = await _repository.subscribe(product);

      result.fold((failure) => emit(SubscriptionError(failure.message)), (_) {
        emit(SubscriptionSuccess());
      });
    } catch (e) {
      emit(SubscriptionError('Purchase failed: ${e.toString()}'));
    }
  }

  Future<void> checkSubscription() async {
    try {
      final result = await _repository.isUserSubscribed();

      result.fold((failure) => emit(SubscriptionError(failure.message)), (
        isSubscribed,
      ) {
        if (isSubscribed) {
          emit(SubscriptionActive());
        } else {
          emit(SubscriptionInactive());
        }
      });
    } catch (e) {
      emit(SubscriptionError('Failed to verify: ${e.toString()}'));
    }
  }

  Future<void> restorePurchases() async {
    emit(SubscriptionLoading());

    try {
      final result = await _repository.restorePurchase();

      result.fold((failure) => emit(SubscriptionError(failure.message)), (_) {
        // Check subscription after restore
        checkSubscription();
      });
    } catch (e) {
      emit(SubscriptionError('Failed to restore: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    return super.close();
  }
}
