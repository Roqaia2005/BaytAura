import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';

class AppNavBar extends StatelessWidget {
  final int currentPageIndex;
  final ValueChanged<int> onDestinationSelected;

  const AppNavBar({
    super.key,
    required this.currentPageIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentPageIndex,
      backgroundColor: Colors.white,
      indicatorColor: AppColors.beige,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home, color: AppColors.blue),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.search, color: AppColors.blue),
          label: "Search",
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_border, color: AppColors.blue),
          label: "Favorites",
        ),
        NavigationDestination(
          icon: Icon(Icons.message_outlined, color: AppColors.blue),
          label: "Messages",
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline, color: AppColors.blue),
          label: "Profile",
        ),
      ],
    );
  }
}
