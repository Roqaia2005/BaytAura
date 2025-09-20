import 'package:flutter/material.dart';
import 'package:bayt_aura/core/widgets/ai_button.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';
import 'package:bayt_aura/features/customer/presentation/views/add_property_view.dart';

import 'package:bayt_aura/features/customer/presentation/widgets/customer_navbar.dart';
import 'package:bayt_aura/features/property/presentation/views/all_properties_view.dart';

class CustomerView extends StatefulWidget {
  const CustomerView({super.key});

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  final List<Widget> screens = [
    AllPropertiesView(),
    AddPropertyView(),
    ProfileView(),
  ];
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AIButton(),
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomerNavBar(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          currentPageIndex = index;
          setState(() {});
        },
      ),
      body: screens[currentPageIndex],
    );
  }
}
