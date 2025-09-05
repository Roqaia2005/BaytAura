import 'package:flutter/material.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/info_widget.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/signout_button.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/support_container.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/account_container.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/activity_container.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/quick_actions_container.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileAppBar(),
            QuickActionsContainer(),
            AccountContainer(),
            ActivityContainer(),
            SupportContainer(),
            InfoWidget(),
            SignoutButton(),
          ],
        ),
      ),
    );
  }
}
