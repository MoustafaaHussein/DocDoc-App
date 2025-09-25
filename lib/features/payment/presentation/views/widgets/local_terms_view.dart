import 'package:flutter/material.dart';

class LocalTermsScreen extends StatelessWidget {
  const LocalTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms of Use")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text("""
Welcome to our app. By using our service, you agree to the following terms:

1. Our app uses AI to analyze your mood and suggest exercises.
2. Access to AI features requires a premium subscription.
3. Subscriptions are billed according to the chosen plan (monthly, annual, etc.).
4. You may cancel your subscription at any time in your device’s account settings.
5. We do not store or share your personal data; all processing is done on your device.

Please read carefully before using the app.
            """, style: TextStyle(fontSize: 16, height: 1.5)),
        ),
      ),
    );
  }
}
