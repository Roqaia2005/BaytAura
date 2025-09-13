import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/app_regex.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  const ConfirmPasswordTextField({super.key});

  @override
  State<ConfirmPasswordTextField> createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      prefixIcon: Icon(Icons.lock_outline, color: AppColors.darkBeige),

      controller: context.read<SignupCubit>().passwordConfirmationController,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please confirm your password";
        } else if (!AppRegex.isConfirmPasswordValid(
          context.read<SignupCubit>().passwordController.text,
          value,
        )) {
          return "Passwords do not match";
        }
        return null;
      },

      hintText: "Confirm Password",
      isObscureText: isObscureText,

      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            isObscureText = !isObscureText;
          });
        },
        child: Icon(
          isObscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.darkBeige,
        ),
      ),
    );
  }
}
