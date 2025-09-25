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
  final TextEditingController _areaController = TextEditingController();

  String? _selectedType;

  final List<String> propertyTypes = [
    "APARTMENT",
    "VILLA",
    "HOUSE",
    "STUDIO",
    "LAND",
  ];

  num? minPrice;
  num? maxPrice;
  RangeValues? currentRange;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        context.read<SearchCubit>().searchOrFilter(query: query);
      } else {
        context.read<PropertyCubit>().fetchProperties();
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
    return Scaffold(
      endDrawer: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          return state.whenOrNull(
                loaded: (properties, favorites) {
                  if (properties.isEmpty) {
                    return const Drawer(
                      child: Center(child: Text("No properties available")),
                    );
                  }

                  minPrice = properties
                      .map((p) => p.price?.toDouble())
                      .reduce((a, b) => a! < b! ? a : b);
                  maxPrice = properties
                      .map((p) => p.price?.toDouble())
                      .reduce((a, b) => a! > b! ? a : b);

                  currentRange ??= RangeValues(
                    minPrice!.toDouble(),
                    maxPrice!.toDouble(),
                  );

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
                              min: minPrice!.toDouble(),
                              max: maxPrice!.toDouble(),
                              divisions: 10,
                              activeColor: AppColors.blue,
                              inactiveColor: Colors.grey.shade300,
                              values: currentRange!,
                              labels: RangeLabels(
                                currentRange!.start.toInt().toString(),
                                currentRange!.end.toInt().toString(),
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
                                  "Min: ${currentRange!.start.toInt()}",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                Text(
                                  "Max: ${currentRange!.end.toInt()}",
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
                                  minPrice: currentRange!.start.toInt(),
                                  maxPrice: currentRange!.end.toInt(),
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
              ) ??
              const Drawer(); // fallback
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeAppBar(searchController: _searchController),
            24.verticalSpace,
            const StatCard(),
            24.verticalSpace,
            const CategoriesHeader(),
            20.verticalSpace,
            const CategoriesGridView(),
            const PropertyHeader(),
            12.verticalSpace,
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, searchState) {
                return searchState.whenOrNull(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      loaded: (results) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final property = results[index];
                            return AdminPropertyCard(
                              key: ValueKey(property.id),
                              property: property,
                              onViewDetails: () {
                                context.pushNamed(
                                  Routes.detailsScreen,
                                  arguments: property,
                                );
                              },
                            );
                          },
                        );
                      },
                    ) ??
                    BlocBuilder<PropertyCubit, PropertyState>(
                      builder: (context, propertyState) {
                        return propertyState.whenOrNull(
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              loaded: (properties, favorites) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  itemCount: properties.length,
                                  itemBuilder: (context, index) {
                                    final property = properties[index];
                                    return AdminPropertyCard(
                                      key: ValueKey(property.id),
                                      property: property,
                                      onViewDetails: () {
                                        context.pushNamed(
                                          Routes.detailsScreen,
                                          arguments: property,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              error: (message) => Center(child: Text(message)),
                            ) ??
                            const SizedBox.shrink();
                      },
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
