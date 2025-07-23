import 'package:equatable/equatable.dart';

class ProPlans extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final String? currency;
  final int? durationDays;
  final String? googleProductId;
  final String? appleProductId;
  final bool? isActive;
  final List<dynamic>? features;

  const ProPlans({
    this.id,
    this.name,
    this.description,
    this.price,
    this.currency,
    this.durationDays,
    this.googleProductId,
    this.appleProductId,
    this.isActive,
    this.features,
  });

  factory ProPlans.fromJson(Map<String, dynamic> json) => ProPlans(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    currency: json['currency'] as String?,
    durationDays: json['durationDays'] as int?,
    googleProductId: json['googleProductId'] as String?,
    appleProductId: json['appleProductId'] as String?,
    isActive: json['isActive'] as bool?,
    features: json['features'] as List<dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'currency': currency,
    'durationDays': durationDays,
    'googleProductId': googleProductId,
    'appleProductId': appleProductId,
    'isActive': isActive,
    'features': features,
  };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      price,
      currency,
      durationDays,
      googleProductId,
      appleProductId,
      isActive,
      features,
    ];
  }
}
