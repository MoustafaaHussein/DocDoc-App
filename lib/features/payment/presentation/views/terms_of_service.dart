import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          'Terms of Service',
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
              'Terms of Service',
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
              '1. Acceptance of Terms',
              'By accessing and using this AI-powered mood detection and exercise recommendation application ("my mood"), you accept and agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use the App.',
            ),

            _buildSection(
              '2. Description of Service',
              'The App provides AI-powered services including:\n\n'
                  '• Real-time mood detection using AI technology\n'
                  '• Personalized exercise recommendations based on detected mood\n'
                  '• Mood tracking and historical analysis\n'
                  '• Premium features available through subscription\n\n'
                  'The App uses artificial intelligence to analyze user inputs and camera data to detect emotional states. Results are suggestions only and should not be considered medical advice.',
            ),

            _buildSection(
              '3. Subscription Terms',
              'Premium features require a paid subscription:\n\n'
                  '• Subscriptions are billed monthly or annually\n'
                  '• Payment will be charged to your Apple ID or Google Play account\n'
                  '• Subscriptions automatically renew unless auto-renew is turned off at least 24 hours before the end of the current period\n'
                  '• You can manage and cancel subscriptions in your account settings\n'
                  '• Refunds are handled according to Apple App Store and Google Play Store policies\n'
                  '• No refunds for partial subscription periods',
            ),

            _buildSection(
              '4. User Responsibilities',
              'You agree to:\n\n'
                  '• Provide accurate information when using the App\n'
                  '• Use the App only for lawful purposes\n'
                  '• Not attempt to reverse engineer or hack the App\n'
                  '• Not share your account with others\n'
                  '• Grant necessary permissions (camera, if applicable) for mood detection features\n'
                  '• Understand that AI suggestions are not medical advice',
            ),

            _buildSection(
              '5. Health and Medical Disclaimer',
              'IMPORTANT: This App is NOT a medical device and does not provide medical advice, diagnosis, or treatment.\n\n'
                  '• Mood detection results are AI-generated estimates and may not be accurate\n'
                  '• Exercise recommendations are general suggestions only\n'
                  '• Consult a healthcare professional for mental health concerns\n'
                  '• Do not use this App as a substitute for professional medical care\n'
                  '• In case of mental health emergency, contact emergency services immediately\n'
                  '• The App is intended for wellness and entertainment purposes only',
            ),

            _buildSection(
              '6. Camera and Data Usage',
              'For mood detection features:\n\n'
                  '• The App may request camera access to analyze facial expressions\n'
                  '• Camera data is processed in real-time and not stored permanently\n'
                  '• You can revoke camera permissions at any time in device settings\n'
                  '• Mood tracking data is stored locally and may be synced to cloud storage if enabled',
            ),

            _buildSection(
              '7. AI Accuracy and Limitations',
              'You acknowledge that:\n\n'
                  '• AI mood detection is not 100% accurate\n'
                  '• Results may vary based on lighting, camera quality, and other factors\n'
                  '• The App cannot detect all emotional states or mental health conditions\n'
                  '• Exercise recommendations are general and may not suit everyone\n'
                  '• You use the App\'s suggestions at your own discretion and risk',
            ),

            _buildSection(
              '8. Intellectual Property',
              'All content, features, and functionality of the App, including AI models, algorithms, text, graphics, and software, are owned by us and protected by copyright, trademark, and other intellectual property laws. You may not copy, modify, or distribute any part of the App without our written permission.',
            ),

            _buildSection(
              '9. Limitation of Liability',
              'TO THE MAXIMUM EXTENT PERMITTED BY LAW:\n\n'
                  '• The App is provided "AS IS" without warranties of any kind\n'
                  '• We are not liable for any injuries, health issues, or damages resulting from use of the App\n'
                  '• We are not responsible for inaccurate mood detection or unsuitable exercise recommendations\n'
                  '• Our total liability shall not exceed the amount you paid for the subscription',
            ),

            _buildSection(
              '10. Changes to Service',
              'We reserve the right to:\n\n'
                  '• Modify or discontinue any feature at any time\n'
                  '• Update subscription pricing with 30 days notice\n'
                  '• Change these Terms of Service (you will be notified of significant changes)',
            ),

            _buildSection(
              '11. Termination',
              'We may terminate or suspend your access to the App immediately, without prior notice, if you breach these Terms. Upon termination, your right to use the App will cease immediately.',
            ),

            _buildSection(
              '12. Contact Information',
              'If you have any questions about these Terms, please contact us at:\n\n'
                  'Email: khalid314@hotmail.com\n',
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
