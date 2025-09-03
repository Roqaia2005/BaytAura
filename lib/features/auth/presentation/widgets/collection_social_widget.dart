import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionSocialWidget extends StatelessWidget {
  const CollectionSocialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},

            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.beige),

                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              width: 100.w,
              height: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SvgPicture.asset("assets/svgs/google.svg", height: 20.h),
                  horizontalSpace(5),
                  Text("Google", style: TextStyles.font14BlueRegular),
                ],
              ),
            ),
          ),
        ),
        horizontalSpace(20),

        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.beige),
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              width: 100.w,
              height: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svgs/facebook.svg", height: 20.h),
                  horizontalSpace(5),

                  Text("Facebook", style: TextStyles.font14BlueRegular),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
