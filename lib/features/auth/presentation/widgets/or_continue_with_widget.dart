import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class OrContinueWithWidget extends StatelessWidget {
  const OrContinueWithWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "Or continue with",
            style: TextStyles.font14BlueBold,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
