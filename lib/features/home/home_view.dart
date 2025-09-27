import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80.h),

              // Bigger Logo
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/images/Rectangle.jpg"),
              ),

              SizedBox(height: 30.h),

              // App title
              Text(
                "Welcome to BaytAura",
                style: TextStyles.font24WhiteBold.copyWith(
                  color: AppColors.blue,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 12.h),

              // Subtitle
              Text(
                "Discover your dream property or join as a provider. "
                "Start your journey with BaytAura today.",
                style: TextStyles.font14DarkBeigeBold,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.authScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 55.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    elevation: 4,
                    shadowColor: AppColors.blue.withOpacity(0.3),
                  ),
                  child: Text("Get Started", style: TextStyles.font16WhiteBold),
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
