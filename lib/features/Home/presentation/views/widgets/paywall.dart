import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaywallScreen extends StatefulWidget {
  final List<ProductDetails>? products;

  const PaywallScreen({super.key, this.products});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load products if not already loaded
    if (widget.products == null || widget.products!.isEmpty) {
      Future.microtask(() {
        context.read<SubscriptionCubit>().loadProducts();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.products ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Column(
          children: [
            // Close Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),

                    // Title
                    const Text(
                      "Unlock Premium",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Get full access to all features and premium content.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),

                    const SizedBox(height: 24),

                    // Locked Content Preview
                    _buildLockedContent(),

                    const SizedBox(height: 24),

                    // Products List or Loading
                    if (products.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(),
                      )
                    else
                      Column(
                        children: List.generate(
                          products.length,
                          (index) => _buildPlanCard(index, products[index]),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Subscribe Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed:
                            products.isEmpty
                                ? null
                                : () {
                                  context
                                      .read<SubscriptionCubit>()
                                      .buySubscription(products[selectedIndex]);
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent.shade400,
                          disabledBackgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "Subscribe",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Restore Purchase
                    TextButton(
                      onPressed: () {
                        context.read<SubscriptionCubit>().restorePurchases();
                      },
                      child: const Text(
                        "Restore Purchase",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Apple Compliance Text
                    const Text(
                      "Payment will be charged to your Apple ID account at the confirmation of purchase. "
                      "Subscription automatically renews unless auto-renew is turned off at least 24-hours "
                      "before the end of the current period. You can manage and cancel your subscriptions "
                      "in your App Store account settings.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Terms & Privacy
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // TODO: Open Terms of Service URL
                            GoRouter.of(
                              context,
                            ).push(AppRouter.kTermsOfServiceView);
                          },
                          child: const Text(
                            "Terms of Service",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () {
                            // TODO: Open Privacy Policy URL
                            GoRouter.of(
                              context,
                            ).push(AppRouter.kPrivacyPolicyView);
                          },
                          child: const Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What you'll unlock",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          _LockedItem(text: "✔ Full access to workouts"),
          _LockedItem(text: "✔ Personalized AI recommendations"),
          _LockedItem(text: "✔ Progress tracking"),
          _LockedItem(text: "✔ Premium content library"),
        ],
      ),
    );
  }

  Widget _buildPlanCard(int index, ProductDetails product) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            width: 2,
            color: isSelected ? Colors.greenAccent.shade400 : Colors.white12,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                ],
              ),
            ),
            Text(
              product.price,
              style: TextStyle(
                color:
                    isSelected ? Colors.greenAccent.shade400 : Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// LOCKED ITEM WIDGET
// ============================================
class _LockedItem extends StatelessWidget {
  final String text;
  const _LockedItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 13),
      ),
    );
  }
}
