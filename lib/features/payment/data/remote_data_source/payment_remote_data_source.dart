import 'package:docdoc_app/core/helpers/api_service.dart';
import 'package:docdoc_app/core/helpers/constants.dart';
import 'package:docdoc_app/features/payment/data/models/get_pro_plans/datum.dart';

abstract class PaymentRemoteDataSource {
  Future<List<ProPlans>> getProPlans();
}

class PaymentRemoteDataSourceImplementation extends PaymentRemoteDataSource {
  final ApiService apiService;

  PaymentRemoteDataSourceImplementation({required this.apiService});
  @override
  Future<List<ProPlans>> getProPlans() async {
    var response = await apiService.get(
      endPoint: '/api/payment/plans',
      token: Constants.token,
    );
    List<ProPlans> proPlans = [];
    for (var items in response['data']) {
      proPlans.add(ProPlans.fromJson(items));
    }
    return proPlans;
  }
}
