import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/widgets/custom_drop_down.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/customer/logic/customer_cubit.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';
import 'package:bayt_aura/features/customer/presentation/views/upload_image_view.dart';

class AddPropertyView extends StatefulWidget {
  const AddPropertyView({super.key});

  @override
  State<AddPropertyView> createState() => _AddPropertyViewState();
}

class _AddPropertyViewState extends State<AddPropertyView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _areaController = TextEditingController();
  final _addressController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _ownerNameController = TextEditingController();

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
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter title" : null,
                  ),
                  verticalSpace(12),

                  CustomDropDown(
                    value: _selectedType,
                    itemsList: propertyTypes,
                    onChanged: (val) => setState(() => _selectedType = val),
                    hintText: "Select property type",
                  ),
                  verticalSpace(12),

                  CustomDropDown(
                    value: _selectedPurpose,
                    itemsList: purposes,
                    onChanged: (val) => setState(() => _selectedPurpose = val),
                    hintText: "Select purpose",
                  ),
                  verticalSpace(12),

                  CustomDropDown(
                    value: _selectedStatus,
                    itemsList: statuses,
                    onChanged: (val) => setState(() => _selectedStatus = val),
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
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter description" : null,
                  ),
                  verticalSpace(20),

                  AppTextFormField(
                    controller: _priceController,
                    hintText: "Price",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(
                      Icons.attach_money,
                      color: AppColors.darkBeige,
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter price" : null,
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
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter area" : null,
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _addressController,
                    hintText: "Address",
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: AppColors.darkBeige,
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter address" : null,
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
                    validator: (v) => v == null || double.tryParse(v) == null
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
                    validator: (v) => v == null || double.tryParse(v) == null
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
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter owner name" : null,
                  ),
                  verticalSpace(24),

                  AppTextButton(
                    buttonText: "Submit Property Request",
                    textStyle: TextStyles.font16WhiteBold,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      if (_selectedType == null ||
                          _selectedPurpose == null ||
                          _selectedStatus == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please select type, purpose and status",
                            ),
                          ),
                        );
                        return;
                      }

                      final newRequest = CustomerRequest(
                        id: 0, // السيرفر هيرجع id
                        title: _titleController.text.trim(),
                        type: _selectedType!,
                        purpose: _selectedPurpose!,
                        description: _descriptionController.text.trim(),
                        price: double.parse(_priceController.text.trim()),
                        area: double.parse(_areaController.text.trim()),
                        address: _addressController.text.trim(),
                        latitude: double.parse(_latitudeController.text.trim()),
                        longitude: double.parse(
                          _longitudeController.text.trim(),
                        ),
                        images: [],
                        status: _selectedStatus!,
                        customerName: _ownerNameController.text.trim(),
                      );

                      final cubit = context.read<CustomerRequestCubit>();
                      final propertyId = await cubit.createRequest(newRequest);

                      if (propertyId != null) {
                        // نفتح صفحة رفع الصور ونمرر الـ propertyId
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UploadPropertyImagesView(
                              propertyId: propertyId,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Failed to create property request"),
                          ),
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
