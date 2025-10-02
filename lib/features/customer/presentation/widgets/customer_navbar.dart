import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: NavigationBar(
        height: 80.h,
        elevation: 0,
        backgroundColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: AppColors.beige.withOpacity(0.3),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelTextStyle: WidgetStateProperty.all(TextStyles.font12DarkBeigeBold),
        selectedIndex: currentPageIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: [
          _buildDestination(Icons.home, "Properties", 0),
          _buildDestination(Icons.receipt_long, "My Requests", 1),
          _buildDestination(Icons.home_work, "My Properties", 2),
          NavigationDestination(
            icon: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.blue,
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
            label: "Add",
          ),
          _buildDestination(FontAwesomeIcons.heart, "Favorites", 4),
          _buildDestination(Icons.person_outline, "Profile", 5),
        ],
      ),
    );
  }

  NavigationDestination _buildDestination(
    IconData icon,
    String label,
    int index,
  ) {
    final bool isSelected = currentPageIndex == index;
    return NavigationDestination(
      icon: Icon(
        icon,
        size: isSelected ? 28 : 24,
        color: isSelected ? AppColors.blue : Colors.grey,
      ),
      label: label,
    );
  }
}
