import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/custom_drop_down.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';


class PropertyFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController areaController;
  final TextEditingController addressController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final String? selectedType;
  final String? selectedPurpose;
  final List<String> propertyTypes;
  final List<String> purposes;
  final ValueChanged<String?> onTypeChanged;
  final ValueChanged<String?> onPurposeChanged;

  const PropertyFormFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
    required this.areaController,
    required this.addressController,
    required this.latitudeController,
    required this.longitudeController,
    required this.selectedType,
    required this.selectedPurpose,
    required this.propertyTypes,
    required this.purposes,
    required this.onTypeChanged,
    required this.onPurposeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          controller: titleController,
          hintText: "Title",
          prefixIcon: const Icon(Icons.title, color: AppColors.darkBeige),
          validator: (v) => v == null || v.isEmpty ? "Enter title" : null,
        ),
        verticalSpace(12),
        CustomDropDown(
          value: selectedType,
          itemsList: propertyTypes,
          onChanged: onTypeChanged,
          hintText: "Select property type",
        ),
        verticalSpace(12),
        CustomDropDown(
          value: selectedPurpose,
          itemsList: purposes,
          onChanged: onPurposeChanged,
          hintText: "Select purpose",
        ),
        verticalSpace(12),
        AppTextFormField(
          controller: descriptionController,
          hintText: "Description",
          prefixIcon: const Icon(Icons.description, color: AppColors.darkBeige),
          validator: (v) => v == null || v.isEmpty ? "Enter description" : null,
        ),
        verticalSpace(12),
        AppTextFormField(
          controller: priceController,
          hintText: "Price",
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(
            Icons.attach_money,
            color: AppColors.darkBeige,
          ),
          validator: (v) => v == null || v.isEmpty ? "Enter price" : null,
        ),
        verticalSpace(12),
        AppTextFormField(
          controller: areaController,
          hintText: "Area (sq ft)",
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.square_foot, color: AppColors.darkBeige),
          validator: (v) => v == null || v.isEmpty ? "Enter area" : null,
        ),
        verticalSpace(12),
        AppTextFormField(
          controller: addressController,
          hintText: "Address",
          prefixIcon: const Icon(Icons.location_on, color: AppColors.darkBeige),
          validator: (v) => v == null || v.isEmpty ? "Enter address" : null,
        ),
        verticalSpace(12),
        AppTextFormField(
          controller: latitudeController,
          hintText: "Latitude",

          prefixIcon: const Icon(Icons.explore, color: AppColors.darkBeige),
          validator: (v) => v == null || double.tryParse(v) == null
              ? "Enter valid latitude"
              : null,
        ),
        verticalSpace(12),
        AppTextFormField(
          controller: longitudeController,
          hintText: "Longitude",

          prefixIcon: const Icon(
            Icons.explore_outlined,
            color: AppColors.darkBeige,
          ),
          validator: (v) => v == null || double.tryParse(v) == null
              ? "Enter valid longitude"
              : null,
        ),
      ],
    );
  }
}
