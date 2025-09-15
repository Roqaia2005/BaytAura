import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/features/home/logic/property_state.dart';
import 'package:bayt_aura/features/home/logic/property_cubit.dart';
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
        const HomeAppBar(),
        verticalSpace(24),

        // Stats Row
        const StatCard(),
        verticalSpace(24),

        // Categories
        const CategoriesHeader(),
        verticalSpace(20),
        const CategoriesGridView(),

        // Featured Section
        const FeaturedHeader(),
        verticalSpace(12),

        // Properties Section (from Cubit)
        BlocBuilder<PropertyCubit, PropertyState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),

              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),

              loaded: (properties, favorites) {
                return Column(
                  children: properties.map(
                    (property) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: PropertyCard(
                        property: property,
                        onViewDetails: () {
                          context.pushNamed(
                            Routes.detailsScreen,
                            arguments: property,
                          );
                        },
                      ),
                    ),
                  ).toList(),
                );
              },

              error: (message) => Center(child: Text(message)),
            );
          },
        ),
      ],
    );
  }
}
