import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PropertyFormScaffold extends StatelessWidget {
  final String title;
  final Widget formFields;
  final Widget imagesSection;
  final Widget submitButton;
  final PreferredSizeWidget? appBar;
  final GlobalKey<FormState> formKey; // 👈 add this

  const PropertyFormScaffold({
    super.key,
    required this.title,
    required this.formFields,
    required this.imagesSection,
    required this.submitButton,
    required this.formKey, // 👈 require it
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar ??
          AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColors.blue,
            title: Text(title, style: TextStyles.font24WhiteBold),
          ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.sp),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Form( // 👈 wrap in Form
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Property Info", style: TextStyles.font20BlueBold),
                  SizedBox(height: 16.h),
                  formFields,
                  SizedBox(height: 20.h),
                  Text("Images", style: TextStyles.font20BlueBold),
                  SizedBox(height: 12.h),
                  imagesSection,
                  SizedBox(height: 20.h),
                  submitButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
