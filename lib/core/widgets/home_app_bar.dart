import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/search/presentation/widgets/search_container.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(0),
      ),
      // width: double.infinity,
      child: Column(
        children: [
          // Header
          Text("Find Your Dream Home", style: TextStyles.font24WhiteBold),
          verticalSpace(4),
          Text(
            "Discover luxury properties with AI assistance",
            style: TextStyles.font14DarkBeigeBold,
          ),
          verticalSpace(16),

          // Search Bar
          SearchContainer(searchController: SearchController()),
        ],
      ),
    );
  }
}
