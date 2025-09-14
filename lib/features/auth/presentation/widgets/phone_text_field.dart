import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/app_regex.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      prefixIcon: Icon(Icons.phone, color: AppColors.darkBeige),
      controller: context.read<SignupCubit>().phoneController,
      hintText: "+20 10 1234 5678",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your phone number";
        }
        if (!AppRegex.isPhoneNumberValid(value)) {
          return "Please enter a valid phone number";
        }
        return null;
      },
    );
  }
}
