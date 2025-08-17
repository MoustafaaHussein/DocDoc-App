import 'package:bloc/bloc.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/payment_remote_data_source.dart';
import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'offering_state.dart';

class OfferingCubit extends Cubit<OfferingState> {
  OfferingCubit(this.paymentRemoteDataSource) : super(OfferingInitial());
  final PaymentRemoteDataSource paymentRemoteDataSource;

  Future<void> fetchOfferings() async {
    List<Package> packages = [];
    emit(OfferingLoading());
    try {
      final offerings = await paymentRemoteDataSource.getOfferings();
      if (offerings != null && offerings.current != null) {
        if (offerings.current!.monthly != null) {
          packages.add(offerings.current!.monthly!);
        } else if (offerings.current!.sixMonth != null) {
          packages.add(offerings.current!.sixMonth!);
        } else if (offerings.current!.annual != null) {
          packages.add(offerings.current!.annual!);
          packages.add(offerings.current!.annual!);
        }
        emit(OfferingLoaded(packages));
      } else {
        emit(OfferingLoaded(packages));
      }
    } catch (e) {
      emit(OfferingError(e.toString()));
    }
  }

  Future<void> purchasePackage(Package package, Function onSuccess) async {
    emit(OfferingLoading());
    try {
      PurchaseResult purchaseResult =
          await paymentRemoteDataSource.PurchesPackage(package);
      if (purchaseResult.customerInfo.entitlements.active.containsKey(
        "pro membership",
      )) {
        onSuccess();
        emit(OfferingLoaded([package]));
      } else {
        emit(const OfferingError("Purchase failed"));
      }
      onSuccess();
    } catch (e) {
      emit(OfferingError(e.toString()));
    }
  }
}
