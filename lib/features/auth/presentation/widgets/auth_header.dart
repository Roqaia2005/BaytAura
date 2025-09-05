import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/auth_app_bar.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthAppBar(),
        Text("Join Our Elite Community", style: TextStyles.font20BlueBold),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Access Exclusive luxury properties and AI-powered recommendations",
            style: TextStyles.font14BlueRegular,
          ),
        ),
      ],
    );
  }
}
