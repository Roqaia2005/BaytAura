import 'dart:async';
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
import 'package:bayt_aura/core/widgets/app_circular_indicator.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/presentation/widgets/stat_card.dart';
import 'package:bayt_aura/features/customer/presentation/widgets/property_card.dart';
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
  final TextEditingController _minAreaController = TextEditingController();
  final TextEditingController _maxAreaController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();

  String? _selectedType;
  String? _selectedPurpose;
  Timer? _debounce;

  final List<String> propertyTypes = [
    "APARTMENT",
    "VILLA",
    "HOUSE",
    "STUDIO",
    "LAND",
  ];

  final List<String> purposes = ["RENT", "SALE"];

  RangeValues currentRange = const RangeValues(0, 1000000);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyCubit>().loadProperties(withFavorites: true);
    });

    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        final query = _searchController.text.trim();

        context.read<PropertyCubit>().loadProperties(
          withFavorites: true,
          query: query.isNotEmpty ? query : null,
        );
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _minAreaController.dispose();
    _maxAreaController.dispose();
    _ownerController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double minPrice = 0;
    const double maxPrice = 1000000;

    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: StatefulBuilder(
        builder: (context, setState) {
          return Drawer(
            width: 200.w,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Filter Properties",
                      style: TextStyles.font16BlueBold.copyWith(
                        fontSize: 18.sp,
                      ),
                    ),
                    16.verticalSpace,

                    // Price Range Section
                    _buildSectionTitle("Price Range"),
                    RangeSlider(
                      min: minPrice,
                      max: maxPrice,
                      divisions: 50,
                      activeColor: AppColors.blue,
                      inactiveColor: Colors.grey.shade300,
                      values: currentRange,
                      labels: RangeLabels(
                        currentRange.start.toInt().toString(),
                        currentRange.end.toInt().toString(),
                      ),
                      onChanged: (values) {
                        setState(() => currentRange = values);
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

                    // Property Type
                    _buildSectionTitle("Property Type"),
                    CustomDropDown(
                      value: _selectedType,
                      itemsList: propertyTypes,
                      hintText: "Select Property Type",
                      onChanged: (value) =>
                          setState(() => _selectedType = value),
                    ),
                    20.verticalSpace,

                    // Purpose
                    _buildSectionTitle("Purpose"),
                    CustomDropDown(
                      value: _selectedPurpose,
                      itemsList: purposes,
                      hintText: "Select Purpose",
                      onChanged: (value) =>
                          setState(() => _selectedPurpose = value),
                    ),
                    20.verticalSpace,

                    // Area
                    _buildSectionTitle("Area (m²)"),
                    AppTextFormField(
                      hintText: "Min Area",
                      controller: _minAreaController,
                      keyboardType: TextInputType.number,
                    ),
                    10.verticalSpace,
                    AppTextFormField(
                      hintText: "Max Area",
                      controller: _maxAreaController,
                      keyboardType: TextInputType.number,
                    ),
                    20.verticalSpace,

                    // Owner
                    _buildSectionTitle("Owner"),
                    AppTextFormField(
                      hintText: "Owner Name",
                      controller: _ownerController,
                    ),
                    30.verticalSpace,

                    // Apply button
                    AppTextButton(
                      buttonText: "Apply Filters",
                      textStyle: TextStyles.font14WhiteBold,
                      onPressed: () {
                        context.read<PropertyCubit>().loadProperties(
                          withFavorites: true,
                          query: _searchController.text.trim().isNotEmpty
                              ? _searchController.text.trim()
                              : null,
                          type: _selectedType,
                          minPrice: currentRange.start.toInt(),
                          maxPrice: currentRange.end.toInt(),
                          minArea: int.tryParse(_minAreaController.text),
                          maxArea: int.tryParse(_maxAreaController.text),
                          owner: _ownerController.text.isNotEmpty
                              ? _ownerController.text
                              : null,
                          purpose: _selectedPurpose,
                        );
                        context.pop();
                      },
                    ),
                    12.verticalSpace,

                    // Reset
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.blue, width: 1.5.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 20.w,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedType = null;
                          _selectedPurpose = null;
                          _minAreaController.clear();
                          _maxAreaController.clear();
                          _ownerController.clear();
                          currentRange = const RangeValues(minPrice, maxPrice);
                        });

                        context.read<PropertyCubit>().loadProperties(
                          withFavorites: true,
                        );
                        context.pop();
                      },
                      child: Text(
                        "Reset Filters",
                        style: TextStyles.font14BlueRegular.copyWith(
                          color: AppColors.blue,
                          fontSize: 14.sp,
                        ),
                      ),
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
          SliverToBoxAdapter(
            child: HomeAppBar(searchController: _searchController),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
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
                loaded: (properties, favorites) {
                  if (properties.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: Text("No properties found")),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final property = properties[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 12.w,
                        ),
                        child: PropertyCard(
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
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: TextStyles.font16BlueBold.copyWith(fontSize: 15.sp),
      ),
    );
  }
}
