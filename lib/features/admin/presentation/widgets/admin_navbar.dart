import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

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
      labelPadding: EdgeInsets.only(left: 2),

      labelTextStyle: WidgetStateProperty.all(
        TextStyles.font14DarkBeigeBold.copyWith(),
      ),
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
          icon: Icon(Icons.how_to_reg, color: AppColors.blue),
          label: "Provider Requests",
        ),
        NavigationDestination(
          icon: Icon(Icons.add_home, color: AppColors.blue),
          label: "Customer Requests",
        ),

        NavigationDestination(
          icon: Icon(Icons.person_outline, color: AppColors.blue),
          label: "Profile",
        ),
      ],
    );
  }
}
