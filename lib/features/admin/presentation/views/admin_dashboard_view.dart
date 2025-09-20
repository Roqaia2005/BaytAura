import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/features/admin/presentation/widgets/admin_navbar.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';
import 'package:bayt_aura/features/admin/presentation/views/customer_requests_view.dart';
import 'package:bayt_aura/features/property/presentation/views/all_properties_view.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final List<Widget> screens = [
    AllRequestsView(),

    AllPropertiesView(),

    ProfileView(),
  ];
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.blue,
        onPressed: () {},
        child: SvgPicture.asset("assets/svgs/ai.svg"),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: AdminNavBar(
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
