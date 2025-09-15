import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/widgets/custom_drop_down.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';
import 'package:bayt_aura/features/home/logic/property_cubit.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedType;

  final List<String> propertyTypes = [
    "APARTMENT",
    "VILLA",
    "HOUSE",
    "STUDIO",
    "LAND",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.blue,
        title: Text("Add New Property", style: TextStyles.font24WhiteBold),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.sp),
        child: Card(
          color: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Property Info", style: TextStyles.font20BlueBold),
                  verticalSpace(16),

                  AppTextFormField(
                    controller: _titleController,
                    hintText: "Title",
                    prefixIcon: const Icon(
                      Icons.title,
                      color: AppColors.darkBeige,
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter title" : null,
                  ),
                  verticalSpace(12),

                  CustomDropDown(
                    value: _selectedType,
                    itemsList: propertyTypes,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                    hintText: "Select property type",
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _descriptionController,
                    hintText: "Description",
                    prefixIcon: const Icon(
                      Icons.description,
                      color: AppColors.darkBeige,
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter description"
                        : null,
                  ),
                  verticalSpace(20),

                  Text("Details", style: TextStyles.font20BlueBold),
                  verticalSpace(16),

                  AppTextFormField(
                    controller: _priceController,
                    hintText: "Price",
                    prefixIcon: const Icon(
                      Icons.attach_money,
                      color: AppColors.darkBeige,
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter price" : null,
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _areaController,
                    hintText: "Area (sq ft)",
                    prefixIcon: const Icon(
                      Icons.square_foot,
                      color: AppColors.darkBeige,
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter area" : null,
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _addressController,
                    hintText: "Address",
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: AppColors.darkBeige,
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter address" : null,
                  ),
                  verticalSpace(24),

                  AppTextButton(
                    buttonText: "Add Property",
                    textStyle: TextStyles.font16WhiteBold,

                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_selectedType == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select property type"),
                            ),
                          );
                          return;
                        }

                        final newProperty = Property(
                          id: '',
                          title: _titleController.text,
                          description: _descriptionController.text,
                          price: double.parse(_priceController.text),
                          area: double.parse(_areaController.text),
                          address: _addressController.text,
                          type: _selectedType!,
                          latitude: 99,
                          longitude: 99,
                        );

                        context.read<PropertyCubit>().addProperty(newProperty);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Property Added!")),
                        );
                        // context.pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
