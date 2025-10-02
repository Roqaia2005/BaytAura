import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/widgets/app_circular_indicator.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyCubit>().loadProperties(withFavorites: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        elevation: 0,
        centerTitle: true,
        title: Text("Admin Dashboard", style: TextStyles.font24WhiteBold),
      ),
      backgroundColor: Colors.grey.shade100,
      body: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverToBoxAdapter(child: const StatCard()),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(child: const CategoriesHeader()),
              SliverToBoxAdapter(child: const CategoriesGridView()),
              SliverToBoxAdapter(child: const PropertyHeader()),
              SliverToBoxAdapter(child: SizedBox(height: 12.h)),

              state.maybeWhen(
                loading: () => const SliverFillRemaining(
                  child: Center(child: AppCircularIndicator()),
                ),
                loaded: (properties, _) {
                  if (properties.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: Text("No properties found")),
                    );
                  }

                  return SliverFillRemaining(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          final cubit = context.read<PropertyCubit>();
                          cubit.loadProperties(
                            page: cubit.currentPage + 1,
                            limit: 20,
                            withFavorites: false,
                          );
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: properties.length + 1,
                        itemBuilder: (context, index) {
                          if (index == properties.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: AppCircularIndicator()),
                            );
                          }
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
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 12.w,
                              ),
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
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                error: (message) => SliverFillRemaining(
                  child: Center(
                    child: Text(
                      message,
                      style: TextStyles.font14BlueRegular.copyWith(
                        color: Colors.red,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                orElse: () => const SliverFillRemaining(
                  child: Center(child: AppCircularIndicator()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
