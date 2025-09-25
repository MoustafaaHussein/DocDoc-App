import 'package:flutter/material.dart';

class LocalPrivacyScreen extends StatelessWidget {
  const LocalPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text("""
We respect your privacy. Here’s how we handle your data:

1. We do not sell or share your personal data with third parties.
2. The AI feature uses your device’s camera to analyze mood but no images are stored or transmitted.
3. Subscription and payment data is handled securely by the app store .
4. We may collect minimal usage data to improve the app experience.
5. You can contact us for questions or data-related requests at:Khalid.19823144@gmail.com

Using the app means you agree to this Privacy Policy.
            """, style: TextStyle(fontSize: 16, height: 1.5)),
        ),
      ),
    );
  }
}
