import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

/// 🔹 Extracted AppBar
class EditAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.blue,
      title: Text("Edit Property", style: TextStyles.font24WhiteBold),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}