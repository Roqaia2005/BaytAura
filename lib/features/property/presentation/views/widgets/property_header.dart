import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class PropertyHeader extends StatelessWidget {
  const PropertyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Properties", style: TextStyles.font20BlueBold)],
      ),
    );
  }
}
