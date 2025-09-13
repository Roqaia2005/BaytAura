import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      indicatorShape: CircleBorder(),
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
          icon: CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.blue,
            child: Icon(Icons.add, color: Colors.white),
          ),
          label: "New Post",
        ),
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.image, color: AppColors.blue),

          label: "Posts",
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline, color: AppColors.blue),
          label: "Profile",
        ),
      ],
    );
  }
}
