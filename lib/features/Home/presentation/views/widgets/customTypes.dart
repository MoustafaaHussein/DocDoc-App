import 'package:docdoc_app/core/themes/app_styles.dart';
import 'package:flutter/material.dart';

class CustomJournalTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const CustomJournalTile({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      margin: const EdgeInsets.only(right: 12), // مسافة بين العناصر
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: const Color(0xFF573926)),
          const SizedBox(width: 12),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: AppStyles.styleBold16(
                context,
              ).copyWith(color: Color(0xFF573926)),
            ),
          ),
        ],
      ),
    );
  }
}
