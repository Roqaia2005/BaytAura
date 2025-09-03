import 'package:flutter/material.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/stat_card.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/featured_card.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/featured_header.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/categories_header.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/categories_grid_view.dart';



class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomeAppBar(),
          const SizedBox(height: 12),

          verticalSpace(20),

          // Stats Row
          StatCard(),
          verticalSpace(24),

          // Categories
          CategoriesHeader(),
          verticalSpace(20),
          CategoriesGridView(),

          // Featured Section
          FeaturedHeader(),
          verticalSpace(12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return FeaturedCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}

