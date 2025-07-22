import 'package:docdoc_app/core/helpers/methods.dart';
import 'package:flutter/material.dart';

class EmojisList extends StatelessWidget {
  const EmojisList({super.key, required this.receivedEmojis});

  final List<String> receivedEmojis;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>?> selectedEmojis = convertToEmojiDetails(
      receivedEmojis,
    );

    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedEmojis.length,
        itemBuilder: (context, index) {
          final emoji = selectedEmojis[index];
          if (emoji == null) return const SizedBox();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(emoji['imagePath'], width: 40, height: 40),
                const SizedBox(height: 4),
                Text(emoji['name'], style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}
