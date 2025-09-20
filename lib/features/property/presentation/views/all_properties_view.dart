import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/widgets/home_app_bar.dart';
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
  final TextEditingController _roomsController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  String? _selectedType;

  final List<String> propertyTypes = [
    "APARTMENT",
    "VILLA",
    "HOUSE",
    "STUDIO",
    "LAND",
  ];
  RangeValues currentRange = const RangeValues(2000, 8000);

  @override
  void initState() {
    super.initState();
    context.read<PropertyCubit>().fetchProperties();
    _searchController.addListener(() {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        context.read<SearchCubit>().search(query);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _roomsController.dispose();
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
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text("Filter Properties", style: TextStyles.font14BlueRegular),
                const SizedBox(height: 12),

                Text("Price Range", style: TextStyles.font14BlueRegular),
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
                    Text("Min: ${currentRange.start.toInt()}"),
                    Text("Max: ${currentRange.end.toInt()}"),
                  ],
                ),
                const SizedBox(height: 20),

                CustomDropDown(
                  value: _selectedType,
                  itemsList: propertyTypes,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                AppTextFormField(
                  hintText: "Number of rooms",
                  controller: _roomsController,
                ),
                const SizedBox(height: 20),

                AppTextFormField(
                  hintText: "Min Area (m²)",
                  controller: _areaController,
                ),
                const SizedBox(height: 20),

                AppTextButton(
                  buttonText: "Apply Filters",
                  textStyle: TextStyles.font14WhiteBold,
                  onPressed: () {
                    context.read<SearchCubit>().applyFilter(
                      type: _selectedType,
                      minPrice: currentRange.start.toInt(),
                      maxPrice: currentRange.end.toInt(),
                      rooms: int.tryParse(_roomsController.text),
                      minArea: int.tryParse(_areaController.text),
                    );
                    context.pop();
                  },
                ),
              ],
            ),
          );
        },
      ),

      body: ListView(
        children: [
          HomeAppBar(searchController: _searchController),
          verticalSpace(24),

          // Stats Row
          const StatCard(),
          verticalSpace(24),

          // Categories
          const CategoriesHeader(),
          verticalSpace(20),
          const CategoriesGridView(),

          const PropertyHeader(),
          verticalSpace(12),

          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, searchState) {
              return searchState.when(
                initial: () {
                  // Show all properties by default
                  return BlocBuilder<PropertyCubit, PropertyState>(
                    builder: (context, propertyState) {
                      return propertyState.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        loaded: (properties, favorites) {
                          return Column(
                            children: properties
                                .map(
                                  (property) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
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
                                )
                                .toList(),
                          );
                        },
                        error: (message) => Center(child: Text(message)),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (results) {
                  return Column(
                    children: results
                        .map(
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
                        )
                        .toList(),
                  );
                },
                error: (message) => Center(child: Text(message)),
              );
            },
          ),
        ],
      ),
    );
  }
}
