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
      padding: EdgeInsets.symmetric(vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(0),
      ),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Column(
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.darkBeige),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: Text(
                              "Member since Jan 2024",
                              style: TextStyles.font12DarkBeigeBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
