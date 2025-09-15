import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/search/presentation/widgets/custom_search_bar.dart';


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
              child: CustomSearchBar(searchController: searchController),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              child: Row(
                children: [
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
