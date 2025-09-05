import 'package:flutter/material.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/role_drop_down.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/phone_text_field.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/email_text_field.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/password_text_field.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/name_text_field_section.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/confirm_password_text_field.dart';

Widget buildSignupForm(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      key: const ValueKey(2),
      children: [
        Text("I am a", style: TextStyles.font14BlueBold),
        verticalSpace(10),

        RoleDropdown(),
        verticalSpace(20),

        NameTextFieldSection(context: context),
        verticalSpace(20),
        Text("Email Address", style: TextStyles.font14BlueBold),
        verticalSpace(10),
        EmailTextField(context: context),

        verticalSpace(20),
        Text("Phone number", style: TextStyles.font14BlueBold),
        verticalSpace(10),
        PhoneTextField(context: context),
        verticalSpace(20),

        Text("Create password", style: TextStyles.font14BlueBold),
        verticalSpace(10),
        PasswordTextField(context: context),

        verticalSpace(20),

        Text("Confirm password", style: TextStyles.font14BlueBold),
        verticalSpace(10),
        ConfirmPasswordTextField(context: context),

        verticalSpace(20),

        AppTextButton(
          buttonText: "Join Bayt Aura Elite",
          textStyle: TextStyles.font14DarkBeigeBold,
          onPressed: () {},
        ),
        verticalSpace(20),

        Center(
          child: Text(
            "By joining, you agree to our Terms of Services and Privacy Policy",
            style: TextStyles.font14BlueRegular,
          ),
        ),
        verticalSpace(5),

        Center(
          child: Text(
            "Experience luxury real state redefined",
            style: TextStyles.font12DarkBeigeRegular,
          ),
        ),
        verticalSpace(20),
      ],
    ),
  );
}
