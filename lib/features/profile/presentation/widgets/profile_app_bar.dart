import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(0),
      ),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.beige,
                  radius: 80.r,
                  child: CircleAvatar(
                    radius: 70.r,
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                ),
                horizontalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("John Doe", style: TextStyles.font24WhiteBold),
                    verticalSpace(12),
                    Text(
                      "Premium member",
                      style: TextStyles.font16DarkBeigeRegular,
                    ),
                    verticalSpace(10),

                    Container(
                      width: 120.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.darkBeige),
                      ),
                      child: Center(
                        child: Text(
                          "Member since Jan 2024",
                          style: TextStyles.font12DarkBeigeBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("12", style: TextStyles.font24WhiteBold),
                    Text("Favorites", style: TextStyles.font12DarkBeigeRegular),
                  ],
                ),
                Column(
                  children: [
                    Text("5", style: TextStyles.font24WhiteBold),
                    Text("Search", style: TextStyles.font12DarkBeigeRegular),
                  ],
                ),
                Column(
                  children: [
                    Text("8", style: TextStyles.font24WhiteBold),
                    Text("Viewings", style: TextStyles.font12DarkBeigeRegular),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
