import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.property,
    required this.onViewDetails,
  });

  final Property property;
  final void Function() onViewDetails;

  String formatPrice(double price) {
    return "${price.toStringAsFixed(0)} EGP";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Container(
        padding: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(2, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: Image.network(
                "https://media.istockphoto.com/id/1150278000/photo/modern-white-house-with-swimming-pool.jpg?s=612x612&w=0&k=20&c=5uBhkdER9uGSXKOt_AZjxOXAYjnhxj6b8JCW1UWv2WA=",
                height: 190.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            verticalSpace(12),

            /// Title & Price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      property.title,
                      style: TextStyles.font16BlueBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    formatPrice(property.price),
                    style: TextStyles.font14BlueRegular,
                  ),
                ],
              ),
            ),
            verticalSpace(8),

            /// Address
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.blue,
                    size: 18.sp,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      property.address,
                      style: TextStyles.font14BlueBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(8),

            /// Area + Type
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.square_foot,
                        color: AppColors.darkBeige,
                        size: 18.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "${property.area} m²",
                        style: TextStyles.font14BlueRegular,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: AppColors.darkBeige),
                    ),
                    child: Text(
                      property.type,
                      style: TextStyles.font14BlueBold,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(8),

            /// Short Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                property.description,
                style: TextStyles.font14BlueRegular,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            verticalSpace(12),

            /// View details button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppTextButton(
                verticalPadding: 4.h,
                buttonWidth: double.infinity,
                buttonHeight: 36.h,
                backgroundColor: AppColors.blue,
                buttonText: "View Details",
                textStyle: TextStyles.font14WhiteBold,
                onPressed: onViewDetails,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
