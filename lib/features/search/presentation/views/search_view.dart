import 'package:flutter/material.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/helpers/properties_test.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/property_card.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/search_container.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  List<Property> _filteredProperties = [];

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
          .where((property) => property.name.toLowerCase().contains(query))
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
    return Scaffold(
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
