import 'dart:io';

import 'package:docdoc_app/features/payment/presentation/views/widgets/local_privacy_view.dart';
import 'package:docdoc_app/features/payment/presentation/views/widgets/local_terms_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsPrivacyScreen extends StatelessWidget {
  const TermsPrivacyScreen({super.key});

  final String appleEulaUrl =
      "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/";

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    return Scaffold(
      appBar: AppBar(title: const Text("Terms & Privacy"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We value your privacy and transparency. "
              "Please review the following documents:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            if (isIOS) ...[
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text("End User License Agreement (EULA)"),
                onTap: () => _launchUrl(appleEulaUrl),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text("Privacy Policy"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocalPrivacyScreen(),
                    ),
                  );
                },
              ),
            ] else ...[
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text("Terms of Use"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocalTermsScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text("Privacy Policy"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocalPrivacyScreen(),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
