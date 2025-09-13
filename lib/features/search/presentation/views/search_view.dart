import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/helpers/properties_test.dart';
import 'package:bayt_aura/core/widgets/custom_drop_down.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';
import 'package:bayt_aura/features/search/presentation/widgets/search_container.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/property_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  List<Property> _filteredProperties = [];
  String? _selectedType;

  final List<String> propertyTypes = [
    "APARTMENT",
    "VILLA",
    "HOUSE",
    "STUDIO",
    "LAND",
  ];

  @override
  void initState() {
    super.initState();
    _filteredProperties = properties;

    _searchController.addListener(() {
      filterProperties();
    });
  }

  void filterProperties() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProperties = properties
          .where((property) => property.title.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double minPrice = 1000;
    double maxPrice = 10000;
    RangeValues currentRange = const RangeValues(2000, 8000);
    return Scaffold(
      backgroundColor: Colors.white,

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

                AppTextFormField(hintText: "Number of rooms"),
                const SizedBox(height: 20),

                AppTextFormField(hintText: "Min Area (m²)"),
                const SizedBox(height: 20),

                AppTextButton(
                  buttonText: "Apply Filters",
                  textStyle: TextStyles.font14WhiteBold,
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
      body: Column(
        children: [
          SearchContainer(searchController: _searchController),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProperties.length,
              itemBuilder: (context, index) {
                return PropertyCard(
                  property: _filteredProperties[index],
                  onViewDetails: () {
                    context.pushNamed(
                      Routes.detailsScreen,
                      arguments: _filteredProperties[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
