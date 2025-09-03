import 'package:flutter/material.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/auth_toggle.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/auth_header.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/build_login_form.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/build_Signup_form.dart';


class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AuthHeader(),

          verticalSpace(20),

          // --- blended toggle buttons ---
          AuthToggle(
            showLogin: showLogin,
            onLoginTap: () => setState(() => showLogin = true),
            onSignupTap: () => setState(() => showLogin = false),
          ),

          verticalSpace(20),

          // --- form section (switchable) ---
          Expanded(
            child: SingleChildScrollView(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: showLogin
                    ? buildLoginForm(context)
                    : buildSignupForm(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
