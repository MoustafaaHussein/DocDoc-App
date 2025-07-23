import 'package:equatable/equatable.dart';

import 'datum.dart';

class GetProPlans extends Equatable {
  final bool? success;
  final String? message;
  final List<ProPlans>? data;

  const GetProPlans({this.success, this.message, this.data});

  factory GetProPlans.fromJson(Map<String, dynamic> json) => GetProPlans(
    success: json['success'] as bool?,
    message: json['message'] as String?,
    data:
        (json['data'] as List<dynamic>?)
            ?.map((e) => ProPlans.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [success, message, data];
}
