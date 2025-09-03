import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: AppColors.blue),
        suffixIcon: Container(
          width: 30.w,
          margin: EdgeInsets.only(right: 12, top: 4),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.filter_alt_outlined, color: Colors.white),
        ),
        hintText: "Search location, property type...",
        hintStyle: TextStyles.font14BlueRegular,
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
