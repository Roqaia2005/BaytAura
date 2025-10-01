import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

class CustomerRequestDetailsView extends StatelessWidget {
  final CustomerRequest customerRequest;
  const CustomerRequestDetailsView({super.key, required this.customerRequest});

  String formatPrice(double? price) =>
      price != null ? "${price.toStringAsFixed(0)} EGP" : "N/A";

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "N/A";
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd').format(parsed);
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 80.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: PageView.builder(
                      itemCount: customerRequest.images?.isNotEmpty == true
                          ? customerRequest.images!.length
                          : 1,
                      itemBuilder: (context, index) {
                        final image =
                            (customerRequest.images != null &&
                                customerRequest.images!.isNotEmpty)
                            ? customerRequest.images![index].url
                            : null;
                        debugPrint("Image URL: $image");

                        final displayUrl = (image != null && image.isNotEmpty)
                            ? image
                            : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzeOx66im4ySs9Zl0a3spwB6yhDRvHrIc4OQ&s";

                        return ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24.r),
                            bottomRight: Radius.circular(24.r),
                          ),
                          child: Image.network(
                            displayUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              debugPrint("Image failed to load: $displayUrl");
                              return const Center(
                                child: Icon(Icons.broken_image, size: 50),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  verticalSpace(20),

                  /// Title + Price
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            customerRequest.title,
                            style: TextStyles.font20BlueBold.copyWith(
                              fontSize: 22.sp,
                            ),
                          ),
                        ),
                        Text(
                          formatPrice(customerRequest.price),
                          style: TextStyles.font20BlueBold.copyWith(
                            color: AppColors.darkBeige,
                          ),
                        ),
                      ],
                    ),
                  ),

                  verticalSpace(10),

                  /// Location
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
                            customerRequest.address,
                            style: TextStyles.font14BlueRegular.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  verticalSpace(20),

                  /// Info Cards
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        runSpacing: 16.h,
                        children: [
                          _infoTile(
                            Icons.square_foot,
                            "${customerRequest.area} m²",
                            "Area",
                          ),
                          _infoTile(
                            Icons.home_work_outlined,
                            customerRequest.type,
                            "Type",
                          ),
                          _infoTile(
                            Icons.flag,
                            customerRequest.purpose,
                            "Purpose",
                          ),
                          _infoTile(
                            Icons.check_circle,
                            customerRequest.status ?? "N/A",
                            "Status",
                          ),
                          _infoTile(
                            Icons.person,
                            customerRequest.customerName ?? "N/A",
                            "Owner",
                          ),
                        ],
                      ),
                    ),
                  ),

                  verticalSpace(24),

                  /// Description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "Property Details",
                      style: TextStyles.font16BlueBold.copyWith(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  verticalSpace(8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      customerRequest.description,
                      style: TextStyles.font14BlueRegular.copyWith(
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Back button
            Positioned(
              top: 16.h,
              left: 16.w,
              child: _circleButton(
                icon: Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
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
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
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
    return SizedBox(
      width: 100.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.blue, size: 22.sp),
          verticalSpace(4),
          Text(
            value,
            style: TextStyles.font14BlueRegular,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            label,
            style: TextStyles.font14BlueRegular.copyWith(
              color: Colors.grey,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
