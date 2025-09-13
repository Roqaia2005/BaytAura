import 'package:flutter/material.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/helpers/properties_test.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/stat_card.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/property_card.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/featured_header.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/categories_header.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/categories_grid_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HomeAppBar(),

        verticalSpace(24),

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

        ...properties.map(
          (property) => Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16,),
            child:PropertyCard(
              property: property,
              onViewDetails: () {
                context.pushNamed(Routes.detailsScreen, arguments: property);
              },
            ),
          ),
        ),
      ],
    );
  }
}
