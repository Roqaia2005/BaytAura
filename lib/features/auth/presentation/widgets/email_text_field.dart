import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/app_regex.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      prefixIcon: Icon(Icons.email_outlined, color: AppColors.darkBeige),
      controller: context.read<LoginCubit>().emailController,
      hintText: "Email",
      validator: (value) {
        if (value == null || value.isEmpty || AppRegex.isEmailValid(value)) {
          return "Please enter a valid email";
        }
      },
    );
  }
}