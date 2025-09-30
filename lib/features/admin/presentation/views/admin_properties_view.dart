import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/helpers/app_circular_indicator.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/presentation/widgets/stat_card.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_header.dart';
import 'package:bayt_aura/features/admin/presentation/widgets/admin_property_card.dart';
import 'package:bayt_aura/features/property/presentation/widgets/categories_header.dart';
import 'package:bayt_aura/features/property/presentation/widgets/categories_grid_view.dart';

class AdminPropertiesView extends StatefulWidget {
  const AdminPropertiesView({super.key});

  @override
  State<AdminPropertiesView> createState() => _AdminPropertiesViewState();
}

class _AdminPropertiesViewState extends State<AdminPropertiesView> {
  @override
  void initState() {
    super.initState();

    context.read<PropertyCubit>().loadProperties(withFavorites: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.white,
        elevation: 2,
        foregroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey.shade100,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PropertyCubit>().loadProperties(withFavorites: false);
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
            SliverToBoxAdapter(child: const StatCard()),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
            SliverToBoxAdapter(child: const CategoriesHeader()),
            SliverToBoxAdapter(child: const CategoriesGridView()),
            SliverToBoxAdapter(child: const PropertyHeader()),
            SliverToBoxAdapter(child: SizedBox(height: 12.h)),

            BlocBuilder<PropertyCubit, PropertyState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const SliverFillRemaining(
                    child: Center(child: AppCircularIndicator()),
                  ),
                  loaded: (properties, _) {
                    if (properties.isEmpty) {
                      return const SliverFillRemaining(
                        child: Center(child: Text("No properties found")),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final property = properties[index];
                        return BlocListener<PropertyCubit, PropertyState>(
                          listener: (context, propertyState) {
                            propertyState.maybeWhen(
                              deleted: (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Property deleted successfully",
                                    ),
                                  ),
                                );

                                context.read<PropertyCubit>().loadProperties(
                                  withFavorites: false,
                                );
                              },
                              error: (message) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)),
                                );
                              },
                              orElse: () {},
                            );
                          },
                          child: AdminPropertyCard(
                            key: ValueKey(property.id),
                            property: property,
                            onViewDetails: () {
                              context.pushNamed(
                                Routes.detailsScreen,
                                arguments: property,
                              );
                            },
                          ),
                        );
                      }, childCount: properties.length),
                    );
                  },
                  error: (message) =>
                      SliverFillRemaining(child: Center(child: Text(message))),
                  orElse: () => const SliverFillRemaining(
                    child: Center(child: AppCircularIndicator()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
