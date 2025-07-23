import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'اختر اللغة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(const Locale('ar'));
                    Navigator.pop(context);
                  },
                  child: Text('العربية'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(const Locale('en'));
                    Navigator.pop(context);
                  },
                  child: Text('English'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
