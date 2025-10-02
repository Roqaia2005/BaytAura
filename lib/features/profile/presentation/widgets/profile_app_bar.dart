import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/widgets/app_circular_indicator.dart';
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar with overlay + edit/delete options
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 60.r,
                              backgroundColor: AppColors.beige,
                              backgroundImage: profile.profilePictureUrl != null
                                  ? NetworkImage(profile.profilePictureUrl!)
                                  : const AssetImage(
                                          "assets/images/profile.jpg",
                                        )
                                        as ImageProvider,
                            ),

                            // Edit icon overlay
                            Positioned(
                              bottom: 0,
                              right: 6,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                    ),
                                    builder: (_) => SafeArea(
                                      child: Wrap(
                                        children: [
                                          ListTile(
                                            leading: const Icon(
                                              color: AppColors.darkBeige,
                                              Icons.photo_library,
                                            ),
                                            title: Text(
                                              "Upload new photo",
                                              style: TextStyles.font14BlueBold,
                                            ),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              final picker = ImagePicker();
                                              final file = await picker
                                                  .pickImage(
                                                    source: ImageSource.gallery,
                                                  );
                                              if (file != null) {
                                                context
                                                    .read<ProfileCubit>()
                                                    .uploadProfilePicture(
                                                      File(file.path),
                                                    );
                                              }
                                            },
                                          ),
                                          if (profile.profilePictureUrl != null)
                                            ListTile(
                                              leading: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              title: Text(
                                                "Remove photo",
                                                style:
                                                    TextStyles.font14BlueBold,
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                                context
                                                    .read<ProfileCubit>()
                                                    .deleteProfilePicture();
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor: AppColors.blue,
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),

                            // Loading overlay
                            if (state.maybeWhen(
                              loading: () => true,
                              orElse: () => false,
                            ))
                              Container(
                                width: 120.r,
                                height: 120.r,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: AppCircularIndicator(),
                                ),
                              ),
                          ],
                        ),

                        // Profile info
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Text(
                                  "${profile.firstName} ${profile.lastName}",
                                  style: TextStyles.font16WhiteBold,
                                ),
                              ),
                              verticalSpace(12),
                              Text(
                                profile.role, // ADMIN / PROVIDER / CUSTOMER
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

          // Loading state
          loading: () => const Center(child: AppCircularIndicator()),

          // Deleted state
          deleted: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile deleted successfully!')),
              );
              context.pushReplacementNamed(Routes.homeScreen);
            });
            return const SizedBox.shrink();
          },

          // Error state
          error: (message) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Failed: $message')));
            });
            return const SizedBox.shrink();
          },

          // Default
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
