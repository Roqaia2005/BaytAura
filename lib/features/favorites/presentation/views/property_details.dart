import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/home/logic/property_cubit.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';

class PropertyDetailsView extends StatelessWidget {
  const PropertyDetailsView({super.key, required this.property});
  final Property property;

  String formatPrice(double price) => "${price.toStringAsFixed(0)} EGP";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: property.title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.r),
                      bottomRight: Radius.circular(24.r),
                    ),
                    child: Image.network(
                      "https://media.istockphoto.com/id/1150278000/photo/modern-white-house-with-swimming-pool.jpg?s=612x612&w=0&k=20&c=5uBhkdER9uGSXKOt_AZjxOXAYjnhxj6b8JCW1UWv2WA=",
                      width: double.infinity,
                      height: 280.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                verticalSpace(20),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.title,
                          style: TextStyles.font20BlueBold.copyWith(
                            fontSize: 22.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        formatPrice(property.price),
                        style: TextStyles.font20BlueBold.copyWith(
                          color: AppColors.darkBeige,
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
                        Icons.location_on,
                        color: AppColors.blue,
                        size: 18.sp,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          property.address,
                          style: TextStyles.font14BlueRegular.copyWith(
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                verticalSpace(20),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _infoTile(
                          Icons.square_foot,
                          "${property.area} m²",
                          "Area",
                        ),
                        _infoTile(
                          Icons.home_work_outlined,
                          property.type,
                          "Type",
                        ),
                        _infoTile(
                          Icons.attach_money,
                          formatPrice(property.price),
                          "Price",
                        ),
                      ],
                    ),
                  ),
                ),

                verticalSpace(24),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Property Details",
                    style: TextStyles.font16BlueBold.copyWith(fontSize: 18.sp),
                  ),
                ),
                verticalSpace(8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    property.description,
                    style: TextStyles.font14BlueRegular.copyWith(
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ),
                ),

                verticalSpace(80),
              ],
            ),
          ),

          Positioned(
            top: 40.h,
            left: 16.w,
            child: _circleButton(
              icon: Icons.arrow_back,
              onTap: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 40.h,
            right: 16.w,
            child: BlocBuilder<PropertyCubit, PropertyState>(
              builder: (context, state) {
                bool isFavorite = false;
                if (state is PropertyLoaded) {
                  isFavorite = state.favorites.contains(property);
                }

                return _circleButton(
                  icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey.shade700,
                  onTap: () {
                    context.read<PropertyCubit>().toggleFavorite(property);
                  },
                );
              },
            ),
          ),

          Positioned(
            bottom: 20.h,
            left: 16.w,
            right: 16.w,
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  elevation: 4,
                ),
                onPressed: () {
                  context.pushNamed(Routes.detailsScreen);
                },
                child: Text(
                  "Contact Agent",
                  style: TextStyles.font16BlueBold.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    Color? color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
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
        child: Icon(icon, color: color ?? Colors.black, size: 22.sp),
      ),
    );
  }

  Widget _infoTile(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.blue, size: 22.sp),
        verticalSpace(4),
        Text(value, style: TextStyles.font14BlueRegular),
        Text(
          label,
          style: TextStyles.font14BlueRegular.copyWith(
            color: Colors.grey,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
