import 'package:bloc/bloc.dart';
import 'package:docdoc_app/features/payment/data/remote_data_source/payment_remote_data_source.dart';
import 'package:equatable/equatable.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit(this.paymentRemoteDataSource)
    : super(SubscriptionInitial());
  final PaymentRemoteDataSource paymentRemoteDataSource;

  Future<void> checkProStatus() async {
    emit(SubscriptionLoading());
    try {
      final isPro = await paymentRemoteDataSource.getCustomerInfo();
      emit(SubscriptionLoaded(isPro));
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }
}
