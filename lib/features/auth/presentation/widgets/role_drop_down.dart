import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';

class RoleDropdown extends StatefulWidget {
  const RoleDropdown({super.key});

  @override
  State<RoleDropdown> createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  final List<String> roles = ["Customer", "Provider"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.beige),
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          style: TextStyles.font14BlueRegular,
          value: context.watch<SignupCubit>().selectedRole,
          hint: Row(
            children: [
              const Icon(Icons.person_outline, color: AppColors.darkBeige),
              const SizedBox(width: 8),
              Text("Select your role", style: TextStyles.font14BlueRegular),
            ],
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          isExpanded: true,
          items: roles.map((role) {
            return DropdownMenuItem(value: role, child: Text(role));
          }).toList(),
          onChanged: (value) {
            setState(() {
              if (value != null) {
                context.read<SignupCubit>().setRole(value);
              }
            });
          },
        ),
      ),
    );
  }
}
