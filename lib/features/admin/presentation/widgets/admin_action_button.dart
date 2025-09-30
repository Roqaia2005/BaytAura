import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const AdminActionButton({super.key, 
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