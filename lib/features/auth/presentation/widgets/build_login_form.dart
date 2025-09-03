import 'package:flutter/material.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/forgot_password.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/email_text_field.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/password_text_field.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/or_continue_with_widget.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/collection_social_widget.dart';

Widget buildLoginForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        key: const ValueKey(1),
        children: [
          Text("Email Address", style: TextStyles.font14BlueBold),
          verticalSpace(10),
          EmailTextField(context: context),
          verticalSpace(20),

          Text("Password", style: TextStyles.font14BlueBold),
          verticalSpace(10),

          PasswordTextField(context: context),
          verticalSpace(20),

          AppTextButton(
            buttonText: "Access your account",
            textStyle: TextStyles.font14DarkBeigeBold,
            onPressed: () {},
          ),
          verticalSpace(20),

          ForgotPassword(),
          verticalSpace(20),
          OrContinueWithWidget(),
          verticalSpace(20),

          CollectionSocialWidget(),
          verticalSpace(20),
        ],
      ),
    );
  }
