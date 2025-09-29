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
import 'package:bayt_aura/features/search/logic/search_state.dart';
import 'package:bayt_aura/features/search/logic/search_cubit.dart';
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

  // price slider values
  RangeValues currentRange = const RangeValues(0, 1000000);

  @override
  void initState() {
    super.initState();

    // debounce search
    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        final query = _searchController.text.trim();
        if (query.isNotEmpty) {
          context.read<SearchCubit>().searchOrFilter(query: query);
        } else {
          context.read<SearchCubit>().searchOrFilter();
        }
      });
    });

    // initial load (no filters)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchCubit>().searchOrFilter();
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
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Filter Properties",
                        style: TextStyles.font14BlueRegular.copyWith(fontSize: 16.sp)),
                    12.verticalSpace,

                    // Price Range
                    Text("Price Range",
                        style: TextStyles.font14BlueRegular.copyWith(fontSize: 14.sp)),
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
                        setState(() {
                          currentRange = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Min: ${currentRange.start.toInt()}",
                            style: TextStyle(fontSize: 12.sp)),
                        Text("Max: ${currentRange.end.toInt()}",
                            style: TextStyle(fontSize: 12.sp)),
                      ],
                    ),
                    20.verticalSpace,

                    // Type
                    CustomDropDown(
                      value: _selectedType,
                      itemsList: propertyTypes,
                      hintText: "Select Property Type",
                      onChanged: (value) => setState(() => _selectedType = value),
                    ),
                    20.verticalSpace,

                    // Purpose
                    CustomDropDown(
                      value: _selectedPurpose,
                      itemsList: purposes,
                      hintText: "Select Purpose",
                      onChanged: (value) => setState(() => _selectedPurpose = value),
                    ),
                    20.verticalSpace,

                    // Min / Max Area
                    AppTextFormField(
                      hintText: "Min Area (m²)",
                      controller: _minAreaController,
                      keyboardType: TextInputType.number,
                    ),
                    10.verticalSpace,
                    AppTextFormField(
                      hintText: "Max Area (m²)",
                      controller: _maxAreaController,
                      keyboardType: TextInputType.number,
                    ),
                    20.verticalSpace,

                    // Owner
                    AppTextFormField(
                      hintText: "Owner",
                      controller: _ownerController,
                    ),
                    20.verticalSpace,

                    // Apply button
                    AppTextButton(
                      buttonText: "Apply Filters",
                      textStyle: TextStyles.font14WhiteBold,
                      onPressed: () {
                        context.read<SearchCubit>().searchOrFilter(
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
                        context.pop(); // close drawer
                      },
                    ),
                    10.verticalSpace,

                    // Reset
                    AppTextButton(
                      buttonText: "Reset Filters",
                      textStyle: TextStyles.font14WhiteBold,
                      onPressed: () {
                        setState(() {
                          _selectedType = null;
                          _selectedPurpose = null;
                          _minAreaController.clear();
                          _maxAreaController.clear();
                          _ownerController.clear();
                          currentRange = const RangeValues(minPrice, maxPrice);
                        });
                        context.read<SearchCubit>().searchOrFilter();
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
          SliverToBoxAdapter(child: HomeAppBar(searchController: _searchController)),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          SliverToBoxAdapter(child: const StatCard()),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          SliverToBoxAdapter(child: const CategoriesHeader()),
          SliverToBoxAdapter(child: const CategoriesGridView()),
          SliverToBoxAdapter(child: const PropertyHeader()),
          SliverToBoxAdapter(child: SizedBox(height: 12.h)),

          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const SliverFillRemaining(
                  child: Center(child: AppCircularIndicator()),
                ),
                loaded: (results) {
                  if (results.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: Text("No properties found")),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final property = results[index];
                      return AdminPropertyCard(
                        key: ValueKey(property.id),
                        property: property,
                        onViewDetails: () {
                          context.pushNamed(Routes.detailsScreen, arguments: property);
                        },
                      );
                    }, childCount: results.length),
                  );
                },
                error: (message) => SliverFillRemaining(
                  child: Center(child: Text(message)),
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
}
