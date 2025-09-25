import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/property/presentation/widgets/category_card.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16.w,  // wider horizontal space
        mainAxisSpacing: 16.h,   // wider vertical space
        childAspectRatio: 1.1,   // balance between width/height
        children: const [
          CategoryCard(
            title: "For Rent",
            count: "2.1k available",
            icon: Icons.house_outlined,
          ),
          CategoryCard(
            title: "For Sale",
            count: "1.8k available",
            icon: Icons.home_work_outlined,
          ),
          CategoryCard(
            title: "Furnished",
            count: "890 available",
            icon: Icons.bed_outlined,
          ),
          CategoryCard(
            title: "Commercial",
            count: "420 available",
            icon: Icons.business_outlined,
          ),
        ],
      ),
    );
  }
}
