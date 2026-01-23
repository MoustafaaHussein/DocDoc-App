import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Last updated: January 16, 2025',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 24),

            _buildSection(
              '1. Introduction',
              'We respect your privacy and are committed to protecting your personal data. This Privacy Policy explains how we collect, use, store, and protect your information when you use our AI-powered mood detection and exercise recommendation app.',
            ),

            _buildSection(
              '2. Information We Collect',
              'We collect the following types of information:\n\n'
                  '2.1 Information You Provide:\n'
                  '• Account information (email, name if provided)\n'
                  '• Subscription and payment information (processed by Apple/Google)\n'
                  '• Mood tracking data you manually enter\n'
                  '• Exercise preferences and history\n\n'
                  '2.2 Automatically Collected Information:\n'
                  '• Device information (model, OS version)\n'
                  '• App usage statistics and analytics\n'
                  '• Crash reports and error logs\n'
                  '• IP address and general location (for service optimization)\n\n'
                  '2.3 Camera Data (if you enable mood detection):\n'
                  '• Facial expression data analyzed in real-time\n'
                  '• This data is NOT stored or uploaded to servers\n'
                  '• Processing happens locally on your device',
            ),

            _buildSection(
              '3. How We Use Your Information',
              'We use your information to:\n\n'
                  '• Provide AI-powered mood detection services\n'
                  '• Generate personalized exercise recommendations\n'
                  '• Track your mood history and show trends\n'
                  '• Process subscription payments\n'
                  '• Provide customer support\n'
                  '• Comply with legal requirements',
            ),

            _buildSection(
              '4. Camera and Facial Data',
              'IMPORTANT PRIVACY INFORMATION:\n\n'
                  '• Camera access is used ONLY for real-time mood detection\n'
                  '• Facial expression data is processed locally on your device\n'
                  '• We do NOT store, upload, or share your facial images\n'
                  '• We do NOT use facial recognition or identification\n'
                  '• Only mood analysis results (e.g., "happy", "sad") are saved\n'
                  '• You can deny camera permission and still use other app features',
            ),

            _buildSection(
              '5. Data Storage and Security',
              'We take data security seriously:\n\n'
                  '• If cloud sync is enabled, data is encrypted in transit and at rest\n'
                  '• We use industry-standard security measures\n'
                  '• Payment information is handled by Apple/Google, not stored by us\n'
                  '• Camera data is never stored or transmitted',
            ),

            _buildSection(
              '6. Data Sharing and Third Parties',
              'We do NOT sell your personal data. We may share data with:\n\n'
                  '• Service Providers: Cloud hosting, analytics services (anonymized data only)\n'
                  '• Payment Processors: Apple App Store and Google Play for subscriptions\n'
                  '• AI Service Providers: For improving mood detection (anonymized data only)\n'
                  '• Legal Requirements: If required by law or to protect our rights\n\n'
                  'We do NOT share:\n'
                  '• Your camera/facial data (processed locally only)\n'
                  '• Personal mood tracking details\n'
                  '• Identifiable information for advertising',
            ),

            _buildSection(
              '7. Your Privacy Rights',
              'You have the right to:\n\n'
                  '• Access your personal data\n'
                  '• Request data correction or deletion\n'
                  '• Export your mood tracking data\n'
                  '• Opt-out of analytics data collection\n'
                  '• Withdraw camera permissions at any time\n'
                  '• Cancel your subscription\n'
                  '• Request account deletion\n\n'
                  'To exercise these rights, contact us at privacy@yourapp.com',
            ),

            _buildSection(
              '8. Children\'s Privacy',
              'Our App is not intended for children under 13 years old. We do not knowingly collect personal information from children. If you believe a child has provided us with personal data, please contact us immediately.',
            ),

            _buildSection(
              '9. Data Retention',
              'We retain your data as follows:\n\n'
                  '• Account data: Until you delete your account\n'
                  '• Mood tracking history: Until you delete it or close your account\n'
                  '• Analytics data: Anonymized and retained for 2 years\n'
                  '• Camera/facial data: NOT retained (processed in real-time only)\n'
                  '• Subscription data: As required by law and payment processors',
            ),

            _buildSection(
              '10. International Data Transfers',
              'Your information may be transferred to and processed in countries other than your own. We ensure appropriate safeguards are in place to protect your data in accordance with this Privacy Policy.',
            ),

            _buildSection(
              '11. Cookies and Tracking',
              'The App may use:\n\n'
                  '• Analytics tools to understand app usage (can be disabled)\n'
                  '• Local storage for app functionality\n'
                  '• Session data for authentication\n\n'
                  'We do NOT use tracking for advertising purposes.',
            ),

            _buildSection(
              '12. Changes to This Policy',
              'We may update this Privacy Policy from time to time. We will notify you of significant changes through the App or via email. Your continued use of the App after changes constitutes acceptance of the updated policy.',
            ),

            _buildSection(
              '13. GDPR Compliance (for EU users)',
              'If you are in the European Union:\n\n'
                  '• We process data based on consent and legitimate interests\n'
                  '• You have additional rights under GDPR\n'
                  '• You can lodge complaints with your local data protection authority\n'
                  '• Data transfers outside EU are protected by standard contractual clauses',
            ),

            _buildSection(
              '14. California Privacy Rights (CCPA)',
              'If you are a California resident:\n\n'
                  '• You have the right to know what data we collect\n'
                  '• You can request deletion of your data\n'
                  '• We do NOT sell your personal information\n'
                  '• You can opt-out of data sharing for analytics',
            ),

            _buildSection(
              '15. Contact Us',
              'If you have questions about this Privacy Policy or our data practices:\n\n'
                  'Email: Khalid314@hotmail.com\n',
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
