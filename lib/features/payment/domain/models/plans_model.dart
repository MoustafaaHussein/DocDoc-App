class PlanModel {
  final String title;
  final String price;
  final String subtitle;
  final bool isBest;

  const PlanModel({
    required this.title,
    required this.price,
    required this.subtitle,
    this.isBest = false,
  });
}
