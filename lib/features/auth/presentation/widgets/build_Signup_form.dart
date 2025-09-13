import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/helpers/app_regex.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/role_drop_down.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/phone_text_field.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/signup_bloc_listner.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/name_text_field_section.dart';
import 'package:bayt_aura/features/auth/presentation/widgets/confirm_password_text_field.dart';



class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    final formKey = context.read<SignupCubit>().formKey;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

        
          children: [
            Text("I am a", style: TextStyles.font14BlueBold),
            verticalSpace(10),

            RoleDropdown(),
            verticalSpace(20),

            NameTextFieldSection(),
            verticalSpace(20),

            verticalSpace(10),
            AppTextFormField(
              prefixIcon: Icon(
                Icons.email_outlined,
                color: AppColors.darkBeige,
              ),
              controller: context.read<SignupCubit>().emailController,
              hintText: "Email",
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !AppRegex.isEmailValid(value)) {
                  return "Please enter a valid email";
                }
                return null;
              },
            ),

            verticalSpace(20),
            verticalSpace(20),
            Text("Phone number", style: TextStyles.font14BlueBold),
            verticalSpace(10),
            PhoneTextField(),
            verticalSpace(20),

            Text("Create password", style: TextStyles.font14BlueBold),
            verticalSpace(10),
            AppTextFormField(
              prefixIcon: Icon(Icons.lock_outline, color: AppColors.darkBeige),
              controller: context.read<SignupCubit>().passwordController,
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

            Text("Confirm password", style: TextStyles.font14BlueBold),
            verticalSpace(10),
            ConfirmPasswordTextField(),

            verticalSpace(20),

            AppTextButton(
              buttonText: "Join Bayt Aura Elite",
              textStyle: TextStyles.font14DarkBeigeBold,
              onPressed: () {
                final formState = context
                    .read<SignupCubit>()
                    .formKey
                    .currentState;
                if (formState != null && formState.validate()) {
                  context.read<SignupCubit>().emitSignupStates();
                }
              },
            ),
            verticalSpace(20),
            const SignupBlocListener(),

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
      ),
    );
  }
}
