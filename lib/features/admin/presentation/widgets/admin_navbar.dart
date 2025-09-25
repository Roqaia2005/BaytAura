import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminNavBar extends StatelessWidget {
  final int currentPageIndex;
  final ValueChanged<int> onDestinationSelected;

  const AdminNavBar({
    super.key,
    required this.currentPageIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentPageIndex,
      backgroundColor: Colors.white,
      indicatorShape: CircleBorder(),
      indicatorColor: AppColors.beige,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.personCircleCheck, color: AppColors.blue),
          label: "Provider Requests",
        ),
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.image, color: AppColors.blue),
          label: "Customer Requests",
        ),

        NavigationDestination(
          icon: Icon(Icons.home, color: AppColors.blue),

          label: "Properties",
        ),

        NavigationDestination(
          icon: Icon(Icons.person_outline, color: AppColors.blue),
          label: "Profile",
        ),
      ],
    );
  }
}
