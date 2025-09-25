import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';

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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة العقار مع Gradient Overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: Image.network(
                    property.images != null && property.images!.isNotEmpty
                        ? property.images!.first.url ??
                              "https://via.placeholder.com/400"
                        : "https://via.placeholder.com/400",
                    width: double.infinity,
                    height: 180.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                // نوع العقار
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

            verticalSpace(14),

            // العنوان + السعر
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

            verticalSpace(8),

            // العنوان
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

            verticalSpace(10),

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

            verticalSpace(10),

            // الوصف
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

            verticalSpace(14),
            Divider(color: Colors.grey.shade300, height: 1),

            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                children: [
                  _AdminActionButton(
                    label: "View Details",
                    color: AppColors.blue,
                    onPressed: onViewDetails,
                  ),
                  verticalSpace(10),
                  if (property.id != null)
                    _AdminActionButton(
                      label: "Delete",
                      color: Colors.red,
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Confirm Delete"),
                            content: Text(
                              style: TextStyles.font16BlueBold,
                              "Are you sure you want to delete this property?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: Text(
                                  "Cancel",
                                  style: TextStyles.font14BlueRegular,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          context.read<PropertyCubit>().deleteProperty(
                            property.id!,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Property deleted successfully"),
                            ),
                          );
                        }
                      },
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

class _AdminActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _AdminActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(label, style: TextStyles.font14WhiteBold),
      ),
    );
  }
}
