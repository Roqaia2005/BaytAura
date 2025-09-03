import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';

class AuthToggle extends StatelessWidget {
  final bool showLogin;
  final VoidCallback onLoginTap;
  final VoidCallback onSignupTap;

  const AuthToggle({
    super.key,
    required this.showLogin,
    required this.onLoginTap,
    required this.onSignupTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _buildButton("Login", showLogin, onLoginTap),
          _buildButton("Sign Up", !showLogin, onSignupTap),
        ],
      ),
    );
  }

  Widget _buildButton(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: active ? AppColors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: active ? AppColors.beige : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
