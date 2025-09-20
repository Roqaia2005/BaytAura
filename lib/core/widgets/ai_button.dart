import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';

class AIButton extends StatelessWidget {
  const AIButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: AppColors.blue,
      onPressed: () {},
      child: SvgPicture.asset("assets/svgs/ai.svg"),
    );
  }
}
