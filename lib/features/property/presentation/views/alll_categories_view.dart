import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/property/presentation/views/widgets/category_card.dart';

class AllCategoriesView extends StatelessWidget {
  const AllCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Categories", style: TextStyles.font24WhiteBold),
        centerTitle: true,
        backgroundColor: AppColors.blue,
      ),
      body: ListView(
        children: [
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
          CategoryCard(
            title: "Commercial",
            count: "420 available",
            icon: Icons.business_outlined,
          ),
          CategoryCard(
            title: "Luxury Villas",
            count: "420 available",
            icon: Icons.business_outlined,
          ),
          CategoryCard(
            title: "Student housing",
            count: "420 available",
            icon: Icons.business_outlined,
          ),
        ],
      ),
    );
  }
}
