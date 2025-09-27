import 'package:flutter/material.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class ProviderRequestSubmittedView extends StatelessWidget {
  const ProviderRequestSubmittedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.beige.withOpacity(0.2),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 70,
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                "Request Submitted",
                style: TextStyles.font20BlueBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Message
              Text(
                "Your provider request has been submitted successfully.\n\n"
                "Our team will carefully review your application, and you’ll be notified once a decision has been made.\n\n"
                "Thank you for your interest in joining BaytAura. We look forward to seeing you soon!",
                style: TextStyles.font14DarkBeigeBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Back button
              ElevatedButton(
                onPressed: () => context.pushNamed(Routes.homeScreen),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Back to Home", style: TextStyles.font16WhiteBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
