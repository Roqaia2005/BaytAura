import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/widgets/home_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/widgets/custom_drop_down.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/search/logic/search_state.dart';
import 'package:bayt_aura/features/search/logic/search_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/presentation/widgets/stat_card.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_card.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_header.dart';
import 'package:bayt_aura/features/property/presentation/widgets/categories_header.dart';
import 'package:bayt_aura/features/property/presentation/widgets/categories_grid_view.dart';

class AllPropertiesView extends StatefulWidget {
  const AllPropertiesView({super.key});

  @override
  State<AllPropertiesView> createState() => _AllPropertiesViewState();
}

class _AllPropertiesViewState extends State<AllPropertiesView> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  String? _selectedType;
  final List<String> propertyTypes = [
    "APARTMENT",
    "VILLA",
    "HOUSE",
    "STUDIO",
    "LAND",
  ];

  RangeValues currentRange = const RangeValues(1, 1000000000);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        context.read<SearchCubit>().searchOrFilter(query: query);
      } else {
        context.read<PropertyCubit>().fetchPropertiesWithFavorites();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double minPrice = 1000;
    double maxPrice = 10000;

    return Scaffold(
      endDrawer: StatefulBuilder(
        builder: (context, setState) {
          return Drawer(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Filter Properties",
                      style: TextStyles.font14BlueRegular.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    12.verticalSpace,
                    Text(
                      "Price Range",
                      style: TextStyles.font14BlueRegular.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    RangeSlider(
                      min: minPrice,
                      max: maxPrice,
                      divisions: 10,
                      activeColor: AppColors.blue,
                      inactiveColor: Colors.grey.shade300,
                      values: currentRange,
                      labels: RangeLabels(
                        currentRange.start.toInt().toString(),
                        currentRange.end.toInt().toString(),
                      ),
                      onChanged: (values) {
                        setState(() {
                          currentRange = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Min: ${currentRange.start.toInt()}",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Text(
                          "Max: ${currentRange.end.toInt()}",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    CustomDropDown(
                      value: _selectedType,
                      itemsList: propertyTypes,
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                    ),
                    20.verticalSpace,
                    AppTextFormField(
                      hintText: "Min Area (m²)",
                      controller: _areaController,
                    ),
                    20.verticalSpace,
                    AppTextButton(
                      buttonText: "Apply Filters",
                      textStyle: TextStyles.font14WhiteBold,
                      onPressed: () {
                        context.read<SearchCubit>().searchOrFilter(
                          type: _selectedType,
                          minPrice: currentRange.start.toInt(),
                          maxPrice: currentRange.end.toInt(),
                          minArea: int.tryParse(_areaController.text),
                        );
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverToBoxAdapter(
            child: HomeAppBar(searchController: _searchController),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),

          // Stat Card
          SliverToBoxAdapter(child: const StatCard()),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),

          // Categories Header
          SliverToBoxAdapter(child: const CategoriesHeader()),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          // Categories Grid
          SliverToBoxAdapter(child: const CategoriesGridView()),

          // Property Header
          SliverToBoxAdapter(child: const PropertyHeader()),
          SliverToBoxAdapter(child: SizedBox(height: 12.h)),

          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, searchState) {
              return searchState.whenOrNull(
                    initial: () {
                      return BlocBuilder<PropertyCubit, PropertyState>(
                        builder: (context, propertyState) {
                          if (propertyState is PropertyLoading) {
                            return const SliverFillRemaining(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          if (propertyState is PropertyLoaded) {
                            final properties = propertyState.properties;

                            return SliverList(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final property = properties[index];
                                return PropertyCard(
                                  key: ValueKey(property.id),
                                  property: property,
                                  onViewDetails: () {
                                    context.pushNamed(
                                      Routes.detailsScreen,
                                      arguments: property,
                                    );
                                  },
                                );
                              }, childCount: properties.length),
                            );
                          }

                          if (propertyState is PropertyError) {
                            return SliverFillRemaining(
                              child: Center(child: Text(propertyState.message)),
                            );
                          }

                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        },
                      );
                    },
                    loading: () => const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    loaded: (results) => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final property = results[index];
                        return PropertyCard(
                          key: ValueKey(property.id),
                          property: property,
                          onViewDetails: () {
                            context.pushNamed(
                              Routes.detailsScreen,
                              arguments: property,
                            );
                          },
                        );
                      }, childCount: results.length),
                    ),
                    error: (message) => SliverFillRemaining(
                      child: Center(child: Text(message)),
                    ),
                  ) ??
                  const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
