import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/property/data/models/favorite.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback onViewDetails;

  const PropertyCard({
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: Image.network(
                    property.images != null && property.images!.isNotEmpty
                        ? property.images!.first.url ??
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3i7u-qKtMbAXynJmBf8ag-QB2voTrNt490A&s"
                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3i7u-qKtMbAXynJmBf8ag-QB2voTrNt490A&s",
                    width: double.infinity,
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

                Positioned(
                  top: 12.h,
                  right: 14.w,
                  child: BlocBuilder<PropertyCubit, dynamic>(
                    builder: (context, state) {
                      if (state is PropertyLoaded) {
                        Favorite? existingFavorite;
                        for (var fav in state.favorites) {
                          if (fav.property.id == property.id) {
                            existingFavorite = fav;
                            break;
                          }
                        }
                        final isFavorite = existingFavorite != null;

                        return GestureDetector(
                          onTap: () {
                            if (isFavorite) {
                              context.read<PropertyCubit>().removeFavorite(
                                existingFavorite!,
                              );
                            } else {
                              context.read<PropertyCubit>().addFavorite(
                                property,
                              );
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
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
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey[700],
                              size: 24.sp,
                            ),
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),

            verticalSpace(14),

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
