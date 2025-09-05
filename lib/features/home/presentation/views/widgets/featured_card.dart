import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.all(8),
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
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Modern luxury villa", style: TextStyles.font16BlueBold),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text("4.5", style: TextStyles.font14BlueRegular),
                    ],
                  ),
                ],
              ),
            ),
            verticalSpace(20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: AppColors.blue),
                      Text("Dubai Marina", style: TextStyles.font14BlueBold),
                    ],
                  ),
                  Text(r"$2500/Month", style: TextStyles.font14BlueRegular),
                ],
              ),
            ),
            verticalSpace(20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.darkBeige),
                    ),
                    child: Center(
                      child: Text("villa", style: TextStyles.font14BlueBold),
                    ),
                  ),
                  AppTextButton(
                    borderRadius: 8,
                    buttonWidth: 50.w,
                    buttonHeight: 30.h,
                    backgroundColor: AppColors.blue,
                    buttonText: "view details",
                    textStyle: TextStyles.font14WhiteBold,
                    onPressed: () {},
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
