import 'package:docdoc_app/core/errors/revenucat_failure.dart';
import 'package:docdoc_app/core/services/revenucat_payment_service.dart';
import 'package:docdoc_app/features/payment/domain/repos/subscription_repo.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/subcription_event.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/subcription_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository _repository;

  SubscriptionBloc(this._repository) : super(const SubscriptionInitial()) {
    on<InitializeSubscription>(_onInitialize);
    on<LoadOfferings>(_onLoadOfferings);
    on<PurchasePackageEvent>(_onPurchasePackage);
    on<RestorePurchasesEvent>(_onRestorePurchases);
    on<CheckPremiumStatus>(_onCheckPremiumStatus);
  }

  Future<void> _onInitialize(
    InitializeSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionLoading());

    try {
      // Check premium status on initialization
      final result = await _repository.isPremium();

      result.fold((failure) => emit(SubscriptionError(failure.message)), (
        isPremium,
      ) {
        if (isPremium) {
          // Load customer info if premium
          _loadCustomerInfo(emit);
        } else {
          emit(const PremiumInactive());
        }
      });
    } catch (e) {
      emit(SubscriptionError('Initialization failed: ${e.toString()}'));
    }
  }

  Future<void> _onLoadOfferings(
    LoadOfferings event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionLoading());

    try {
      final result = await _repository.getOfferings();

      result.fold((failure) => emit(SubscriptionError(failure.message)), (
        offerings,
      ) {
        if (offerings.current == null) {
          emit(
            const SubscriptionError(
              'No offerings available. Please try again.',
            ),
          );
        } else {
          emit(OfferingsLoaded(offerings));
        }
      });
    } catch (e) {
      emit(SubscriptionError('Failed to load offerings: ${e.toString()}'));
    }
  }

  Future<void> _onPurchasePackage(
    PurchasePackageEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionLoading());

    try {
      final result = await _repository.purchasePackage(event.package);

      result.fold(
        (failure) {
          if (failure is PurchaseCancelledFailure) {
            emit(const PurchaseCancelled());
          } else {
            emit(SubscriptionError(failure.message));
          }
        },
        (customerInfo) {
          // Check if premium is now active
          if (customerInfo.entitlements.active.containsKey(
            RevenueCatService.entitlementID,
          )) {
            emit(PurchaseSuccess(customerInfo));

            // Transition to premium active after 2 seconds
            Future.delayed(const Duration(seconds: 2), () {
              if (!isClosed) {
                add(const CheckPremiumStatus());
              }
            });
          } else {
            emit(
              const SubscriptionError(
                'Purchase completed but premium not activated',
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(SubscriptionError('Purchase failed: ${e.toString()}'));
    }
  }

  Future<void> _onRestorePurchases(
    RestorePurchasesEvent event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionLoading());

    try {
      final result = await _repository.restorePurchases();

      result.fold((failure) => emit(SubscriptionError(failure.message)), (
        customerInfo,
      ) {
        if (customerInfo.entitlements.active.containsKey(
          RevenueCatService.entitlementID,
        )) {
          emit(RestoreSuccess(customerInfo));

          // Transition to premium active
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!isClosed) {
              emit(PremiumActive(customerInfo));
            }
          });
        } else {
          emit(const SubscriptionError('No active subscriptions found'));
        }
      });
    } catch (e) {
      emit(SubscriptionError('Failed to restore: ${e.toString()}'));
    }
  }

  Future<void> _onCheckPremiumStatus(
    CheckPremiumStatus event,
    Emitter<SubscriptionState> emit,
  ) async {
    try {
      final result = await _repository.isPremium();

      result.fold((failure) => emit(SubscriptionError(failure.message)), (
        isPremium,
      ) async {
        if (isPremium) {
          await _loadCustomerInfo(emit);
        } else {
          emit(const PremiumInactive());
        }
      });
    } catch (e) {
      emit(SubscriptionError('Failed to check status: ${e.toString()}'));
    }
  }

  Future<void> _loadCustomerInfo(Emitter<SubscriptionState> emit) async {
    final customerInfoResult = await _repository.getCustomerInfo();
    customerInfoResult.fold(
      (failure) => emit(SubscriptionError(failure.message)),
      (customerInfo) => emit(PremiumActive(customerInfo)),
    );
  }
}
