import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';

class CustomerNavBar extends StatelessWidget {
  final int currentPageIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomerNavBar({
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

          label: "Properties",
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
          icon: Icon(Icons.person_outline, color: AppColors.blue),
          label: "Profile",
        ),
      ],
    );
  }
}
