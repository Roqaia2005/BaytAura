import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountContainer extends StatefulWidget {
  const AccountContainer({super.key});

  @override
  State<AccountContainer> createState() => _AccountContainerState();
}

class _AccountContainerState extends State<AccountContainer> {
  bool isNotificationOn = false;
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
            Text("Account", style: TextStyles.font16BlueBold),
            verticalSpace(20),
           ListTile(
  leading: Icon(
    FontAwesomeIcons.penToSquare,
    color: AppColors.darkBeige,
  ),
  title: Text("Edit profile", style: TextStyles.font14BlueRegular),
  trailing: IconButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EditProfileScreen()),
      );
    },
    icon: Icon(
      size: 20,
      Icons.arrow_forward_ios,
      color: AppColors.darkBeige,
    ),
  ),
),

            ListTile(
              leading: const Icon(
                FontAwesomeIcons.bell,
                color: AppColors.darkBeige,
              ),
              title: Text(
                "Enable Notifications",
                style: TextStyles.font14BlueRegular,
              ),
              trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                  activeThumbColor: AppColors.darkBeige,
                  inactiveThumbColor: AppColors.blue,
                  inactiveTrackColor: AppColors.darkBeige,
                  activeTrackColor: AppColors.blue,
                  value: isNotificationOn,
                  onChanged: (value) {
                    setState(() {
                      isNotificationOn = value;
                    });
                  },
                ),
              ),
            ),

            ListTile(
              leading: Icon(
                FontAwesomeIcons.shieldHalved,
                color: AppColors.darkBeige,
              ),
              title: Text(
                "Privacy & Security",
                style: TextStyles.font14BlueRegular,
              ),

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
              leading: Icon(FontAwesomeIcons.star, color: AppColors.darkBeige),
              title: Text("My Reviews", style: TextStyles.font14BlueRegular),

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
