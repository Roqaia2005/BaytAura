import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';

class AppCircularIndicator extends StatelessWidget {
  const AppCircularIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: AppColors.darkBeige);
  }
}