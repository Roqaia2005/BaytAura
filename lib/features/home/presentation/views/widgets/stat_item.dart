import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class StatItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const StatItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyles.font16BlueBold),

        Text(subtitle, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}