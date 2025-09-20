import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/core/widgets/custom_drop_down.dart';
import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
import 'package:bayt_aura/features/customer/logic/customer_cubit.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

class AddPropertyView extends StatefulWidget {
  const AddPropertyView({super.key});

  @override
  State<AddPropertyView> createState() => _AddPropertyViewState();
}

class _AddPropertyViewState extends State<AddPropertyView> {
  final _formKey = GlobalKey<FormState>();

  // Image picking
  final List<RequestImages> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage(
        imageQuality: 80,
      );

      if (images != null && images.isNotEmpty) {
        final tempImages = images.map((file) {
          final id = DateTime.now().millisecondsSinceEpoch;
          return RequestImages(
            id: id,
            url: file.path, // local path; replace with uploaded URL when uploading
            altName: file.name,
            publicId: 'public_$id',
          );
        }).toList();

        setState(() {
          _selectedImages.addAll(tempImages);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick images: $e")),
      );
    }
  }

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
                    prefixIcon: const Icon(Icons.title, color: AppColors.darkBeige),
                    validator: (value) => value == null || value.isEmpty ? "Enter title" : null,
                  ),
                  verticalSpace(12),

                  Text("Property Images", style: TextStyles.font20BlueBold),
                  verticalSpace(12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _selectedImages.map((image) {
                      if (image.url == null || image.url!.isEmpty) return const SizedBox();
                      return Stack(
                        children: [
                          image.url!.startsWith('http')
                              ? Image.network(
                                  image.url!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(image.url!),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImages.remove(image);
                                });
                              },
                              child: Container(
                                color: Colors.black54,
                                child: const Icon(Icons.close, color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  verticalSpace(12),
                  AppTextButton(
                    buttonText: "Pick Images",
                    textStyle: TextStyles.font16WhiteBold,
                    onPressed: pickImages,
                  ),

                  CustomDropDown(
                    value: _selectedType,
                    itemsList: propertyTypes,
                    onChanged: (value) => setState(() => _selectedType = value),
                    hintText: "Select property type",
                  ),
                  verticalSpace(12),

                  CustomDropDown(
                    value: _selectedPurpose,
                    itemsList: purposes,
                    onChanged: (value) => setState(() => _selectedPurpose = value),
                    hintText: "Select purpose",
                  ),
                  verticalSpace(12),

                  CustomDropDown(
                    value: _selectedStatus,
                    itemsList: statuses,
                    onChanged: (value) => setState(() => _selectedStatus = value),
                    hintText: "Select property status",
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _descriptionController,
                    hintText: "Description",
                    prefixIcon: const Icon(Icons.description, color: AppColors.darkBeige),
                    validator: (value) => value == null || value.isEmpty ? "Enter description" : null,
                  ),
                  verticalSpace(20),

                  Text("Details", style: TextStyles.font20BlueBold),
                  verticalSpace(16),

                  AppTextFormField(
                    controller: _priceController,
                    hintText: "Price",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.attach_money, color: AppColors.darkBeige),
                    validator: (value) => value == null || value.isEmpty ? "Enter price" : null,
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _areaController,
                    hintText: "Area (sq ft)",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.square_foot, color: AppColors.darkBeige),
                    validator: (value) => value == null || value.isEmpty ? "Enter area" : null,
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _addressController,
                    hintText: "Address",
                    prefixIcon: const Icon(Icons.location_on, color: AppColors.darkBeige),
                    validator: (value) => value == null || value.isEmpty ? "Enter address" : null,
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _latitudeController,
                    hintText: "Latitude",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.explore, color: AppColors.darkBeige),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null
                        ? "Enter valid latitude"
                        : null,
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _longitudeController,
                    hintText: "Longitude",
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.explore_outlined, color: AppColors.darkBeige),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null
                        ? "Enter valid longitude"
                        : null,
                  ),
                  verticalSpace(12),

                  AppTextFormField(
                    controller: _ownerNameController,
                    hintText: "Owner Name",
                    prefixIcon: const Icon(Icons.person, color: AppColors.darkBeige),
                    validator: (value) => value == null || value.isEmpty ? "Enter owner name" : null,
                  ),
                  verticalSpace(24),

                  AppTextButton(
                    buttonText: "Submit Property Request",
                    textStyle: TextStyles.font16WhiteBold,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      if (_selectedType == null || _selectedPurpose == null || _selectedStatus == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select type, purpose and status")),
                        );
                        return;
                      }

                      final newRequest = CustomerRequest(
                        id: DateTime.now().millisecondsSinceEpoch,
                        title: _titleController.text.trim(),
                        type: _selectedType!,
                        purpose: _selectedPurpose!,
                        description: _descriptionController.text.trim(),
                        price: double.parse(_priceController.text.trim()),
                        area: double.parse(_areaController.text.trim()),
                        address: _addressController.text.trim(),
                        latitude: double.parse(_latitudeController.text.trim()),
                        longitude: double.parse(_longitudeController.text.trim()),
                        images: List<RequestImages>.from(_selectedImages),
                        status: _selectedStatus!,
                        customerName: _ownerNameController.text.trim(),
                      );

                      context.read<CustomerRequestCubit>().createRequest(newRequest);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Property adding request submitted")),
                      );
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
