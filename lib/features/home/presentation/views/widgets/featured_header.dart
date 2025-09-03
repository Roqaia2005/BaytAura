import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class FeaturedHeader extends StatelessWidget {
  const FeaturedHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Featured", style: TextStyles.font20BlueBold),
          Text("See All", style: TextStyles.font16DarkBeigeRegular),
        ],
      ),
    );
  }
}