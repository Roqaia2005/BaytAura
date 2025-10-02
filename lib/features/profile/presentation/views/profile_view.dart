import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/core/widgets/app_circular_indicator.dart';
import 'package:bayt_aura/features/profile/logic/profile.state.dart';
import 'package:bayt_aura/features/profile/logic/profile_cubit.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/info_widget.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/signout_button.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/profile_details.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:bayt_aura/features/profile/presentation/widgets/account_container.dart';
// import 'package:bayt_aura/features/profile/presentation/widgets/support_container.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadProfile(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.maybeWhen(
              loaded: (profile) => SingleChildScrollView(
                child: Column(
                  children: [
                    const ProfileAppBar(),
                    ProfileDetails(profile: profile),
                    const AccountContainer(),
                    const InfoWidget(),
                    const SignoutButton(),
                  ],
                ),
              ),
              loading: () => const Center(child: AppCircularIndicator()),
              error: (msg) => Center(child: Text("Error: $msg")),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
