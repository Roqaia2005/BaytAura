import 'package:flutter/material.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/auth_toggle.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/auth_header.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/build_login_form.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/build_signup_form.dart';

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
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          verticalSpace(40),

          AuthHeader(),

          verticalSpace(20),

          AuthToggle(
            showLogin: showLogin,
            onLoginTap: () => setState(() => showLogin = true),
            onSignupTap: () => setState(() => showLogin = false),
          ),

          verticalSpace(20),

          Expanded(
            child: SingleChildScrollView(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: showLogin ? LoginFormWidget() : SignupForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
