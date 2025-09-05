import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportContainer extends StatelessWidget {
  const SupportContainer({super.key});

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
            Text("Support", style: TextStyles.font16BlueBold),
            verticalSpace(20),
            ListTile(
              leading: Icon(
                Icons.help_outline_sharp,
                color: AppColors.darkBeige,
                size: 30,
              ),
              title: Text("Help & FAQ", style: TextStyles.font14BlueRegular),

              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  size: 20,
                  Icons.arrow_forward_ios,
                  color: AppColors.darkBeige,
                ),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.gear, color: AppColors.darkBeige),
              title: Text("App settings", style: TextStyles.font14BlueRegular),

              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  size: 20,
                  Icons.arrow_forward_ios,
                  color: AppColors.darkBeige,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
