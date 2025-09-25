import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/features/search/logic/search_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/admin/presentation/widgets/admin_navbar.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';
import 'package:bayt_aura/features/admin/presentation/views/admin_properties_view.dart';
import 'package:bayt_aura/features/admin/presentation/views/provider_requests.view.dart';
import 'package:bayt_aura/features/admin/presentation/views/customer_requests_view.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int currentPageIndex = 0;

  final List<Widget> screens = const [
    ProviderRequestsView(),
    CustomerRequestsView(),
    AdminPropertiesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SearchCubit>()),
        BlocProvider(create: (_) => getIt<PropertyCubit>()..fetchProperties()),
      ],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColors.blue,
          onPressed: () {},
          child: SvgPicture.asset("assets/svgs/ai.svg"),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: AdminNavBar(
          currentPageIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        body: screens[currentPageIndex],
      ),
    );
  }
}
