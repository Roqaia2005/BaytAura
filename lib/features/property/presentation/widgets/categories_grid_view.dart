import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/property/presentation/widgets/category_card.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        crossAxisSpacing: 1.sp,
        mainAxisSpacing: 0.5.sp,

        physics: const NeverScrollableScrollPhysics(),
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
