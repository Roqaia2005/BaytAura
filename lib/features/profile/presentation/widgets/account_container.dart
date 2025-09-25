import 'package:flutter/material.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bayt_aura/features/profile/presentation/views/edit_profile_screen.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
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
                  context.pushNamed(Routes.editProfile);
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
          ],
        ),
      ),
    );
  }
}
