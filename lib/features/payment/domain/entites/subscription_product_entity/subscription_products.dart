class SubscriptionPlan {
  final String id; // productId
  final String title; // Store title
  final String description; // Store description
  final String price; // Localized price "$4.99"
  final double rawPrice; // 4.99
  final String currencyCode; // USD

  SubscriptionPlan({
    required this.rawPrice,
    required this.currencyCode,
    required this.id,
    required this.title,
    required this.price,
    required this.description,
  });
}
