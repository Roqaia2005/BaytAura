import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';

class NameTextFieldSection extends StatelessWidget {
  const NameTextFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("First Name", style: TextStyles.font14BlueBold),
              verticalSpace(10),

              AppTextFormField(
                hintText: "John",
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: AppColors.darkBeige,
                ),
                controller: context.read<SignupCubit>().firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your first name";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Last Name", style: TextStyles.font14BlueBold),
              verticalSpace(10),

              AppTextFormField(
                hintText: "Doe",
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                  color: AppColors.darkBeige,
                ),
                controller: context.read<SignupCubit>().lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your last name";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
