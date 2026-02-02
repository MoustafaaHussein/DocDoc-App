import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';

class PaywallScreen extends StatefulWidget {
  final List<ProductDetails>? products;

  const PaywallScreen({super.key, this.products});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  int selectedIndex = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    if (widget.products == null || widget.products!.isEmpty) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(milliseconds: 100));

      if (mounted) {
        context.read<SubscriptionCubit>().loadProducts();
      }

      Future.delayed(const Duration(seconds: 10), () {
        if (mounted && _isLoading) {
          setState(() => _isLoading = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.products ?? [];
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Column(
          children: [
            // Close Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: isTablet ? 28 : 24,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 600 : double.infinity,
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 40 : 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),

                        // Title
                        Text(
                          "Unlock Premium",
                          style: TextStyle(
                            fontSize: isTablet ? 32 : 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Get full access to all features and premium content.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isTablet ? 16 : 14,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Locked Content Preview
                        _buildLockedContent(isTablet),

                        const SizedBox(height: 24),

                        // Products List or Loading/Error
                        if (_isLoading || products.isEmpty)
                          _buildLoadingOrError(products.isEmpty && !_isLoading)
                        else
                          Column(
                            children: List.generate(
                              products.length,
                              (index) => _buildPlanCard(
                                index,
                                products[index],
                                isTablet,
                              ),
                            ),
                          ),

                        const SizedBox(height: 24),

                        // Subscribe Button
                        SizedBox(
                          width: double.infinity,
                          height: isTablet ? 56 : 52,
                          child: ElevatedButton(
                            onPressed:
                                products.isEmpty || _isLoading
                                    ? null
                                    : () {
                                      context
                                          .read<SubscriptionCubit>()
                                          .buySubscription(
                                            products[selectedIndex],
                                          );
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent.shade400,
                              disabledBackgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              "Subscribe",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: isTablet ? 18 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Restore Purchase
                        TextButton(
                          onPressed: () {
                            context
                                .read<SubscriptionCubit>()
                                .restorePurchases();
                          },
                          child: Text(
                            "Restore Purchase",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isTablet ? 16 : 14,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Apple Compliance Text (AUTO-RENEWAL INFO)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Payment will be charged to your Apple ID account at the confirmation of purchase. "
                            "Subscription automatically renews unless auto-renew is turned off at least 24 hours "
                            "before the end of the current period. You can manage and cancel your subscriptions "
                            "in your App Store account settings.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 13 : 12,
                              color: Colors.white54,
                              height: 1.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ============================================
                        // LEGAL LINKS - UPDATED FOR APPLE COMPLIANCE
                        // ============================================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Privacy Policy Link (Required)
                            TextButton(
                              onPressed: () {
                                GoRouter.of(
                                  context,
                                ).push(AppRouter.kPrivacyPolicyView);
                              },
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: isTablet ? 13 : 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),

                            Text(
                              " • ",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.3),
                                fontSize: isTablet ? 13 : 12,
                              ),
                            ),

                            // Apple Standard EULA Link (Required)
                            TextButton(
                              onPressed: () => _openAppleEULA(),
                              child: Text(
                                "Terms of Use (EULA)",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: isTablet ? 13 : 12,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // OPEN APPLE'S STANDARD EULA
  // ============================================
  Future<void> _openAppleEULA() async {
    final Uri eulaUrl = Uri.parse(
      'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/',
    );

    try {
      if (await canLaunchUrl(eulaUrl)) {
        await launchUrl(eulaUrl, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open Terms of Use')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  Widget _buildLoadingOrError(bool isError) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          if (isError) ...[
            const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
            const SizedBox(height: 16),
            const Text(
              'Unable to load subscription options',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProducts,
              child: const Text('Retry'),
            ),
          ] else ...[
            const CircularProgressIndicator(color: Colors.greenAccent),
            const SizedBox(height: 16),
            const Text(
              'Loading subscription options...',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLockedContent(bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What you'll unlock",
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 18 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: isTablet ? 14 : 12),
          _LockedItem(text: "✔ AI-Powered Mood Detection", isTablet: isTablet),
          _LockedItem(
            text: "✔ Personalized Exercise Recommendations",
            isTablet: isTablet,
          ),
          _LockedItem(text: "✔ Mood Tracking & Insights", isTablet: isTablet),
          _LockedItem(text: "✔ Unlimited Premium Access", isTablet: isTablet),
        ],
      ),
    );
  }

  Widget _buildPlanCard(int index, ProductDetails product, bool isTablet) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(isTablet ? 20 : 16),
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
            // Radio indicator
            Container(
              width: isTablet ? 26 : 24,
              height: isTablet ? 26 : 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? Colors.greenAccent.shade400 : Colors.white30,
                  width: 2,
                ),
                color:
                    isSelected
                        ? Colors.greenAccent.shade400
                        : Colors.transparent,
              ),
              child:
                  isSelected
                      ? Icon(
                        Icons.check,
                        size: isTablet ? 17 : 16,
                        color: Colors.black,
                      )
                      : null,
            ),
            SizedBox(width: isTablet ? 16 : 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 18 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: isTablet ? 6 : 4),
                  Text(
                    product.description,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: isTablet ? 14 : 13,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              product.price,
              style: TextStyle(
                color:
                    isSelected ? Colors.greenAccent.shade400 : Colors.white70,
                fontSize: isTablet ? 16 : 14,
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
  final bool isTablet;

  const _LockedItem({required this.text, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: TextStyle(color: Colors.white70, fontSize: isTablet ? 14 : 13),
      ),
    );
  }
}
