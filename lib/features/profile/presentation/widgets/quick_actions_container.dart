import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class QuickActionsContainer extends StatelessWidget {
  const QuickActionsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quick Actions", style: TextStyles.font16BlueBold),
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.blue),
                  ),
                  child: Center(
                    child: Text(
                      "My Favorites",
                      style: TextStyles.font14BlueRegular,
                    ),
                  ),
                ),
                horizontalSpace(20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.blue),
                  ),
                  child: Center(
                    child: Text(
                      "Saved searches",
                      style: TextStyles.font14BlueRegular,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
