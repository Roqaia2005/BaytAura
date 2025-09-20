import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/widgets/custom_drop_down.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';

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
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();

  String? _selectedType;
  String? _selectedPurpose;
  String? _selectedStatus;

  final List<String> propertyTypes = [
    "APARTMENT",
    "VILLA",
    "HOUSE",
    "STUDIO",
    "LAND",
  ];

  final List<String> purposes = ["SELL", "RENT"];
  final List<String> statuses = ["AVAILABLE", "SOLD", "RENTED"];

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

                  CustomDropDown(
                    value: _selectedPurpose,
                    itemsList: purposes,
                    onChanged: (value) {
                      setState(() {
                        _selectedPurpose = value;
                      });
                    },
                    hintText: "Select purpose",
                  ),
                  verticalSpace(12),

                  CustomDropDown(
                    value: _selectedStatus,
                    itemsList: statuses,
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    },
                    hintText: "Select property status",
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
                    keyboardType: TextInputType.number,
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
                    keyboardType: TextInputType.number,
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
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _latitudeController,
                    hintText: "Latitude",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      Icons.explore,
                      color: AppColors.darkBeige,
                    ),
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null
                        ? "Enter valid latitude"
                        : null,
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _longitudeController,
                    hintText: "Longitude",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      Icons.explore_outlined,
                      color: AppColors.darkBeige,
                    ),
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null
                        ? "Enter valid longitude"
                        : null,
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _ownerNameController,
                    hintText: "Owner Name",
                    prefixIcon: const Icon(
                      Icons.person,
                      color: AppColors.darkBeige,
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter owner name"
                        : null,
                  ),
                  verticalSpace(24),

                  AppTextButton(
                    buttonText: "Add Property",
                    textStyle: TextStyles.font16WhiteBold,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_selectedType == null ||
                            _selectedPurpose == null ||
                            _selectedStatus == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Please select type, purpose and status"),
                            ),
                          );
                          return;
                        }

                        final now = DateTime.now().toIso8601String();

                        final newProperty = Property(
                          id: DateTime.now().millisecondsSinceEpoch, // unique id
                          title: _titleController.text,
                          description: _descriptionController.text,
                          price: double.parse(_priceController.text),
                          area: double.parse(_areaController.text),
                          address: _addressController.text,
                          type: _selectedType!,
                          purpose: _selectedPurpose!,
                          propertyStatus: _selectedStatus!,
                          latitude:
                              double.parse(_latitudeController.text.trim()),
                          longitude:
                              double.parse(_longitudeController.text.trim()),
                          ownerName: _ownerNameController.text,
                          createdAt: now,
                          updatedAt: now,
                        );

                        context.read<PropertyCubit>().addProperty(newProperty);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Property Added!")),
                        );
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
