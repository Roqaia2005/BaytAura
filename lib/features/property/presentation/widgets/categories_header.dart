import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Categories", style: TextStyles.font20BlueBold)],
      ),
    );
  }
}
