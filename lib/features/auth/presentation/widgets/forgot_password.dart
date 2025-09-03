import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          child: Text(
            "Forgot password?",
            style: TextStyles.font14DarkBeigeBold,
          ),
          onTap: () {},
        ),
        verticalSpace(20),

        Divider(thickness: 0.8, color: AppColors.darkBeige),
      ],
    );
  }
}
