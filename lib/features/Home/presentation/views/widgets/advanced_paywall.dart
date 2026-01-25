import 'package:docdoc_app/core/routes/app_routes.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/subcription_bloc.dart';
import 'package:docdoc_app/features/payment/presentation/manger/bloc/subcription_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';

import '../../../../payment/presentation/manger/bloc/subcription_state.dart';

class AdvancedPaywall extends StatelessWidget {
  const AdvancedPaywall({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<SubscriptionBloc>()..add(const LoadOfferings()),
      child: const _PaywallContent(),
    );
  }
}

class _PaywallContent extends StatefulWidget {
  const _PaywallContent();

  @override
  State<_PaywallContent> createState() => _PaywallContentState();
}

class _PaywallContentState extends State<_PaywallContent> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
          builder: (context, state) {
            if (state is SubscriptionLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.greenAccent),
              );
            }

            if (state is OfferingsLoaded) {
              final packages = state.offerings.current?.availablePackages ?? [];

              if (packages.isEmpty) {
                return _buildErrorView(context);
              }

              return Column(
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: isTablet ? 32 : 28,
                      ),
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
                            children: [
                              // Header
                              _buildHeader(isTablet),
                              const SizedBox(height: 24),

                              // Features
                              _buildFeaturesBox(isTablet),
                              const SizedBox(height: 24),

                              // Packages
                              ...packages.asMap().entries.map((entry) {
                                return _buildPackageCard(
                                  entry.key,
                                  entry.value,
                                  entry.key == selectedIndex,
                                  () =>
                                      setState(() => selectedIndex = entry.key),
                                  isTablet,
                                );
                              }),

                              const SizedBox(height: 24),

                              // Trial notice
                              _buildTrialNotice(isTablet),
                              const SizedBox(height: 24),

                              // Subscribe button
                              _buildSubscribeButton(
                                context,
                                packages[selectedIndex],
                                isTablet,
                              ),
                              const SizedBox(height: 16),

                              // Restore button
                              _buildRestoreButton(context, isTablet),
                              const SizedBox(height: 16),

                              // Compliance text
                              _buildComplianceText(isTablet),
                              const SizedBox(height: 20),

                              // Terms & Privacy
                              _buildLegalLinks(context, isTablet),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            // Error or initial state
            return _buildErrorView(context);
          },
        ),
      ),
    );
  }

  Widget _buildHeader(bool isTablet) {
    return Column(
      children: [
        Text(
          'Unlock AI Premium',
          style: TextStyle(
            fontSize: isTablet ? 36 : 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Start your 3-day free trial',
          style: TextStyle(
            fontSize: isTablet ? 20 : 16,
            color: Colors.greenAccent,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeaturesBox(bool isTablet) {
    final features = [
      _Feature(
        Icons.psychology,
        'AI Mood Detection',
        'Real-time emotional analysis',
      ),
      _Feature(
        Icons.fitness_center,
        'Personalized Exercises',
        'Custom for your mood',
      ),
      _Feature(Icons.show_chart, 'Mood Tracking', 'Weekly insights & patterns'),
      _Feature(Icons.all_inclusive, 'Unlimited Access', 'No restrictions'),
    ];

    return Container(
      padding: EdgeInsets.all(isTablet ? 24 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's included:",
            style: TextStyle(
              fontSize: isTablet ? 22 : 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isTablet ? 20 : 16),
          ...features.map((f) => _buildFeatureItem(f, isTablet)),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(_Feature feature, bool isTablet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isTablet ? 10 : 8),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              feature.icon,
              color: Colors.greenAccent,
              size: isTablet ? 24 : 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: TextStyle(
                    fontSize: isTablet ? 17 : 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  feature.subtitle,
                  style: TextStyle(
                    fontSize: isTablet ? 15 : 13,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(
    int index,
    Package package,
    bool isSelected,
    VoidCallback onTap,
    bool isTablet,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(isTablet ? 22 : 18),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            width: 2,
            color: isSelected ? Colors.greenAccent : Colors.white12,
          ),
        ),
        child: Row(
          children: [
            // Radio button
            Container(
              width: isTablet ? 28 : 24,
              height: isTablet ? 28 : 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.greenAccent : Colors.white30,
                  width: 2,
                ),
                color: isSelected ? Colors.greenAccent : Colors.transparent,
              ),
              child:
                  isSelected
                      ? Icon(
                        Icons.check,
                        size: isTablet ? 18 : 16,
                        color: Colors.black,
                      )
                      : null,
            ),
            SizedBox(width: isTablet ? 16 : 14),

            // Package details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.storeProduct.title.split('(').first.trim(),
                    style: TextStyle(
                      fontSize: isTablet ? 19 : 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: isTablet ? 8 : 6),
                  if (package.storeProduct.introductoryPrice != null)
                    Text(
                      '${package.storeProduct.introductoryPrice!.periodNumberOfUnits} days free, then ${package.storeProduct.priceString}',
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: Colors.white70,
                      ),
                    )
                  else
                    Text(
                      package.storeProduct.priceString,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: Colors.white70,
                      ),
                    ),
                ],
              ),
            ),

            // Price
            Text(
              package.storeProduct.priceString,
              style: TextStyle(
                fontSize: isTablet ? 22 : 20,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.greenAccent : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrialNotice(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.greenAccent,
            size: isTablet ? 28 : 24,
          ),
          const SizedBox(height: 8),
          Text(
            'Start 3-Day Free Trial',
            style: TextStyle(
              fontSize: isTablet ? 18 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try all premium features free for 3 days. Cancel anytime before trial ends to avoid charges.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 15 : 13,
              color: Colors.white.withOpacity(0.7),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton(
    BuildContext context,
    Package package,
    bool isTablet,
  ) {
    return SizedBox(
      width: double.infinity,
      height: isTablet ? 60 : 54,
      child: ElevatedButton(
        onPressed: () {
          context.read<SubscriptionBloc>().add(PurchasePackageEvent(package));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          'Start Free Trial',
          style: TextStyle(
            fontSize: isTablet ? 20 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildRestoreButton(BuildContext context, bool isTablet) {
    return TextButton(
      onPressed: () {
        context.read<SubscriptionBloc>().add(const RestorePurchasesEvent());
      },
      child: Text(
        'Restore Purchase',
        style: TextStyle(
          fontSize: isTablet ? 17 : 15,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildComplianceText(bool isTablet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'After your 3-day free trial, payment will be charged to your Apple ID account. '
        'Subscription automatically renews unless auto-renew is turned off at least 24 hours '
        'before the end of the current period. Manage subscriptions in your App Store account settings.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isTablet ? 13 : 11,
          color: Colors.white.withOpacity(0.5),
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildLegalLinks(BuildContext context, bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            // TODO: Navigate to Terms
            GoRouter.of(context).push(AppRouter.kTermsOfServiceView);
          },
          child: Text(
            'Terms of Service',
            style: TextStyle(
              fontSize: isTablet ? 14 : 12,
              color: Colors.white60,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(width: 12),
        TextButton(
          onPressed: () {
            // TODO: Navigate to Privacy
            GoRouter.of(context).push(AppRouter.kPrivacyPolicyView);
          },
          child: Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: isTablet ? 14 : 12,
              color: Colors.white60,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
            const SizedBox(height: 16),
            const Text(
              'Unable to load subscription options',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<SubscriptionBloc>().add(const LoadOfferings());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String subtitle;

  _Feature(this.icon, this.title, this.subtitle);
}
