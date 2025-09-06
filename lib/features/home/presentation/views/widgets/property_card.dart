import 'package:flutter/material.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';


class PropertyCard extends StatelessWidget {
  const PropertyCard({super.key, required this.property, required this.onViewDetails});
  final Property property;
final  void Function() onViewDetails;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),

        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(2, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),

        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: Image.network(
                height: 190.h,
                width: double.infinity,
                fit: BoxFit.cover,
                "https://media.istockphoto.com/id/1150278000/photo/modern-white-house-with-swimming-pool.jpg?s=612x612&w=0&k=20&c=5uBhkdER9uGSXKOt_AZjxOXAYjnhxj6b8JCW1UWv2WA=",
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(property.name, style: TextStyles.font16BlueBold),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text(property.rate, style: TextStyles.font14BlueRegular),
                    ],
                  ),
                ],
              ),
            ),
            verticalSpace(20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: AppColors.blue),
                      Text(property.location, style: TextStyles.font14BlueBold),
                    ],
                  ),
                  Text(property.price, style: TextStyles.font14BlueRegular),
                ],
              ),
            ),
            verticalSpace(20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: AppColors.darkBeige),
                    ),
                    child: Center(
                      child: Text(
                        property.type,
                        style: TextStyles.font14BlueBold,
                      ),
                    ),
                  ),
                  AppTextButton(
                    // borderRadius: 8,
                    verticalPadding: 4.h,
                    buttonWidth: 120.w,
                    buttonHeight: 30.h,
                    backgroundColor: AppColors.blue,
                    buttonText: "view details",
                    textStyle: TextStyles.font14WhiteBold,
                    onPressed: onViewDetails
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
