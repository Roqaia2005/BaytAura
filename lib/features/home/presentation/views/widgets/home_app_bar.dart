import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/home_search_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

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
          verticalSpace(8),

          // Header
          Text("Find Your Dream Home", style: TextStyles.font24WhiteBold),
          verticalSpace(4),
          Text(
            "Discover luxury properties with AI assistance",
            style: TextStyles.font14DarkBeigeBold,
          ),
          verticalSpace(16),

          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  HomeSearchBar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: AppColors.blue,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Current: Dubai, UAE",
                          style: TextStyles.font14BlueBold,
                        ),
                        Spacer(),
                        Icon(Icons.bolt, color: Colors.orange, size: 18),
                        Text(
                          " AI Powered",
                          style: TextStyles.font12DarkBeigeRegular,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
