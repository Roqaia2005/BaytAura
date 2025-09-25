import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';

class MyPropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback onViewDetails;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MyPropertyCard({
    super.key,
    required this.property,
    required this.onViewDetails,
    required this.onEdit,
    required this.onDelete,
  });

  String formatPrice(num? price) => "${price?.toStringAsFixed(0) ?? 0} EGP";

  @override
  Widget build(BuildContext context) {
    final imageUrl = (property.images != null && property.images!.isNotEmpty)
        ? property.images!.first.url
        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3i7u-qKtMbAXynJmBf8ag-QB2voTrNt490A&s";

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
            // Property Image with Gradient Overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: Image.network(
                    imageUrl ??
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3i7u-qKtMbAXynJmBf8ag-QB2voTrNt490A&s",
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3i7u-qKtMbAXynJmBf8ag-QB2voTrNt490A&s",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
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
                // Property Type
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
                // Edit & Delete buttons instead of favorite
                Positioned(
                  top: 12.h,
                  right: 14.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: onEdit,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.edit,
                            color: AppColors.blue,
                            size: 24.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: onDelete,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            verticalSpace(14),

            // Title & Price
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

            // Location
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

            verticalSpace(10),

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

            verticalSpace(14),
            Divider(color: Colors.grey.shade300, height: 1),

            // View Details Button
            Padding(
              padding: EdgeInsets.all(14.w),
              child: SizedBox(
                width: double.infinity,
                height: 42.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  onPressed: onViewDetails,
                  child: Text(
                    "View Details",
                    style: TextStyles.font14WhiteBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
