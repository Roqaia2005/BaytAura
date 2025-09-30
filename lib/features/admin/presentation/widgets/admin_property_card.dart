import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
// ---------------------- AdminPropertyCard ----------------------

class AdminPropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback onViewDetails;

  const AdminPropertyCard({
    super.key,
    required this.property,
    required this.onViewDetails,
  });

  String formatPrice(num? price) => "${price?.toStringAsFixed(0) ?? 0} EGP";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              child: Stack(
                children: [
                  Image.network(
                    property.images != null && property.images!.isNotEmpty
                        ? property.images!.first.url ??
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzeOx66im4ySs9Zl0a3spwB6yhDRvHrIc4OQ&s"
                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzeOx66im4ySs9Zl0a3spwB6yhDRvHrIc4OQ&s",
                    width: double.infinity,
                    height: 180.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.5),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12.h,
                    left: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.blue, AppColors.darkBeige],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        property.type ?? "",
                        style: TextStyles.font14WhiteBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            verticalSpace(12),

            // Title + Price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      property.title ?? "",
                      style: TextStyles.font16BlueBold.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.blue,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    formatPrice(property.price),
                    style: TextStyles.font16BlueBold.copyWith(
                      color: AppColors.darkBeige,
                      fontSize: 17.sp,
                    ),
                  ),
                ],
              ),
            ),

            verticalSpace(6),

            // Address
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.blue, size: 18.sp),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      property.address ?? "",
                      style: TextStyles.font14BlueRegular.copyWith(
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            verticalSpace(6),

            // Area
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Icon(
                    Icons.square_foot,
                    color: AppColors.darkBeige,
                    size: 18.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "${property.area ?? 0} m²",
                    style: TextStyles.font14BlueRegular,
                  ),
                ],
              ),
            ),

            verticalSpace(8),

            // Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                property.description ?? "",
                style: TextStyles.font14BlueRegular.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            verticalSpace(12),
            Divider(color: Colors.grey.shade300, height: 1),

            // Actions
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: onViewDetails,
                      child: Text(
                        "View Details",
                        style: TextStyles.font16WhiteBold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  if (property.id != null)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(
                                "Confirm Delete",
                                style: TextStyles.font20BlueBold,
                              ),
                              content: Text(
                                style: TextStyles.font17BlueBold,
                                "Are you sure you want to delete this property?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyles.font16BlueBold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            context.read<PropertyCubit>().deleteProperty(
                              property.id!,
                            );
                          }
                        },
                        child: Text(
                          "Delete",
                          style: TextStyles.font16WhiteBold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
