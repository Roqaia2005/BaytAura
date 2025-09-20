import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/helpers/extensions.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';

class PropertyDetailsView extends StatelessWidget {
  final Property property;
  const PropertyDetailsView({super.key, required this.property});

  String formatPrice(double? price) =>
      price != null ? "${price.toString()} EGP" : "N/A";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📸 Images carousel
                SizedBox(
                  height: 280.h,
                  child: PageView.builder(
                    itemCount: property.images?.length ?? 1,
                    itemBuilder: (context, index) {
                      final image =
                          property.images != null && property.images!.isNotEmpty
                          ? property.images![index].url
                          : "https://via.placeholder.com/600x400";

                      return ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24.r),
                          bottomRight: Radius.circular(24.r),
                        ),
                        child: Image.network(
                          image ?? "",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),

                verticalSpace(20),

                // 🏷 Title + Price
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.title ?? "No Title",
                          style: TextStyles.font20BlueBold.copyWith(
                            fontSize: 22.sp,
                          ),
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

                // 📍 Address
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
                          property.address ?? "No Address",
                          style: TextStyles.font14BlueRegular.copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                verticalSpace(20),

                // 📊 Info box
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _infoTile(
                              Icons.square_foot,
                              "${property.area ?? 0} m²",
                              "Area",
                            ),
                            _infoTile(
                              Icons.home_work_outlined,
                              property.type ?? "N/A",
                              "Type",
                            ),
                            _infoTile(
                              Icons.flag,
                              property.purpose ?? "N/A",
                              "Purpose",
                            ),
                          ],
                        ),
                        verticalSpace(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _infoTile(
                              Icons.check_circle,
                              property.propertyStatus ?? "N/A",
                              "Status",
                            ),
                            _infoTile(
                              Icons.person,
                              property.ownerName ?? "N/A",
                              "Owner",
                            ),
                          ],
                        ),
                        verticalSpace(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _infoTile(
                              Icons.calendar_today,
                              property.createdAt ?? "N/A",
                              "Created",
                            ),
                            _infoTile(
                              Icons.update,
                              property.updatedAt ?? "N/A",
                              "Updated",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                verticalSpace(24),

                // 📖 Description
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
                    property.description ?? "No description available",
                    style: TextStyles.font14BlueRegular.copyWith(
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ),
                ),

                verticalSpace(100),
              ],
            ),
          ),

          // 🔙 Back Button
          Positioned(
            top: 40.h,
            left: 16.w,
            child: _circleButton(
              icon: Icons.arrow_back,
              onTap: () => Navigator.pop(context),
            ),
          ),

          // ❤️ Favorite Button

          // 📞 Contact Button
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
