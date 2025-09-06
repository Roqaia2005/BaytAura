import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/home_search_bar.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 36, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.sp, top: 8.sp),
              child: HomeSearchBar(searchController: searchController,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18.sp,
                    color: AppColors.blue,
                  ),
                  SizedBox(width: 6.w),
                  Text("Current: Dubai, UAE", style: TextStyles.font14BlueBold),
                  Spacer(),
                  Icon(Icons.bolt, color: Colors.orange, size: 18.sp),
                  Text(" AI Powered", style: TextStyles.font12DarkBeigeRegular),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
