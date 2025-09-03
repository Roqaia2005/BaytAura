import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/app_regex.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';


class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key, required this.context});

  final BuildContext context;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    bool isObscureText = false;

    return AppTextFormField(
      prefixIcon: Icon(Icons.lock_outline, color: AppColors.darkBeige),

      controller: context.read<SignupCubit>().passwordController,

      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            !AppRegex.isPasswordValid(value)) {
          return "Please enter a valid password";
        }
      },
      hintText: "Password",
      isObscureText: isObscureText,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            isObscureText = isObscureText;
          });
        },
        child: Icon(
          color: AppColors.darkBeige,

          isObscureText ? Icons.visibility_off : Icons.visibility,
        ),
      ),
    );
  }
}