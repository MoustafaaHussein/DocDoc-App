import 'package:flutter/material.dart';

class CustomJournalTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const CustomJournalTile({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
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
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF573926),
              fontSize: 14,
              fontFamily: 'Epilogue',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
