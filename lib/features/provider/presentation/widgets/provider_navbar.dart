import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class ProviderNavBar extends StatelessWidget {
  final int currentPageIndex;
  final ValueChanged<int> onDestinationSelected;

  const ProviderNavBar({
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
