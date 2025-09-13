import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/helpers/app_regex.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/forgot_password.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/login_bloc_listener.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/or_continue_with_widget.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/collection_social_widget.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    final formKey = context.read<LoginCubit>().formKey;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text("Email Address", style: TextStyles.font14BlueBold),
            verticalSpace(10),
            AppTextFormField(
              prefixIcon: Icon(
                Icons.email_outlined,
                color: AppColors.darkBeige,
              ),
              controller: context.read<LoginCubit>().emailController,
              hintText: "Email",
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !AppRegex.isEmailValid(value)) {
                  return "Please enter a valid email";
                }
              },
            ),
            verticalSpace(20),

            Text("Password", style: TextStyles.font14BlueBold),
            verticalSpace(10),
            AppTextFormField(
              prefixIcon: Icon(Icons.lock_outline, color: AppColors.darkBeige),
              controller: context.read<LoginCubit>().passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a valid password";
                }
                if (!AppRegex.isPasswordValid(value)) {
                  return "Password must be at least 8 characters, include an uppercase letter, number and symbol";
                }
                return null;
              },
              hintText: "Password",
              isObscureText: isObscureText,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText; // toggle
                  });
                },
                child: Icon(
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.darkBeige,
                ),
              ),
            ),
            verticalSpace(20),

            AppTextButton(
              buttonText: "Access your account",
              textStyle: TextStyles.font14DarkBeigeBold,
              onPressed: () {
                final formState = context
                    .read<LoginCubit>()
                    .formKey
                    .currentState;
                if (formState != null && formState.validate()) {
                  context.read<LoginCubit>().emitLoginStates();
                }
              },
            ),
            verticalSpace(20),
            const LoginBlocListener(),

            ForgotPassword(),
            verticalSpace(20),
            OrContinueWithWidget(),
            verticalSpace(20),

            CollectionSocialWidget(),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
