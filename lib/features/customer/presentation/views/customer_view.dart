import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/widgets/ai_button.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/features/search/logic/search_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/customer/presentation/views/my_requests.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';
import 'package:bayt_aura/features/property/presentation/views/my_properties.dart';
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
    CustomerRequestsScreen(),
    MyPropertiesView(),
    ProfileView(),
  ];
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SearchCubit>()),
        BlocProvider(create: (_) => getIt<PropertyCubit>()..fetchProperties()),
      ],
      child: Scaffold(
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
      ),
    );
  }
}
