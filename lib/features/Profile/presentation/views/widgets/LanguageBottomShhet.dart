import 'package:docdoc_app/core/helpers/constants.dart';
import 'package:docdoc_app/core/helpers/shared_prefs_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'اختر اللغة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await SharedPrefsHelper.setString(
                      Constants.languageKey,
                      "language=ar",
                    );
                    context.setLocale(const Locale('ar'));
                    Navigator.pop(context);
                  },
                  child: const Text('العربية'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await SharedPrefsHelper.setString(
                      Constants.languageKey,
                      "language=en",
                    );
                    context.setLocale(const Locale('en'));
                    Navigator.pop(context);
                  },
                  child: const Text('English'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
