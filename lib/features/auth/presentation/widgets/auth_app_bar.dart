import 'package:flutter/material.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset("assets/images/logo.png"),
                ),
                horizontalSpace(10),
                Column(
                  children: [
                    Text("BAYT AURA", style: TextStyles.font17BlueBold),
                    Text("REAL ESTATE", style: TextStyles.font10DarkBeigeBold),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
