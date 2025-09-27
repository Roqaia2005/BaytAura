import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/helpers/app_circular_indicator.dart';
import 'package:bayt_aura/features/profile/logic/profile.state.dart';
import 'package:bayt_aura/features/profile/logic/profile_cubit.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (profile) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(0),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.beige,
                          radius: 60.r,
                          child: GestureDetector(
                            onTap: () async {
                              // pick image
                              final picker = ImagePicker();
                              final file = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (file != null) {
                                context
                                    .read<ProfileCubit>()
                                    .uploadProfilePicture(File(file.path));
                              }
                            },
                            child: CircleAvatar(
                              radius: 70.r,
                              backgroundImage: profile.profilePictureUrl != null
                                  ? NetworkImage(profile.profilePictureUrl!)
                                  : const AssetImage(
                                          "assets/images/profile.jpg",
                                        )
                                        as ImageProvider,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${profile.firstName} ${profile.lastName}",
                                style: TextStyles.font24WhiteBold,
                              ),
                              verticalSpace(12),
                              Text(
                                profile
                                    .role, // show ADMIN / PROVIDER / CUSTOMER
                                style: TextStyles.font16DarkBeigeRegular,
                              ),
                              verticalSpace(10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: AppCircularIndicator()),
          orElse: () {
            return Text("something went wrong");
          },
        );
      },
    );
  }
}
