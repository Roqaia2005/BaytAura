import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.value,
    required this.itemsList,
    required this.onChanged,
    this.hintText = "Select property type",
    this.icon,
  });

  final String? value;
  final List<String> itemsList;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final IconData? icon;

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
          value: value,
          hint: Row(
            children: [
              Icon(icon ?? Icons.home_outlined, color: AppColors.darkBeige),
              const SizedBox(width: 8),
              Text(hintText, style: TextStyles.font14BlueRegular),
            ],
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          isExpanded: true,
          items: itemsList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
