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
import 'package:bayt_aura/features/customer/logic/customer_state.dart';
import 'package:bayt_aura/features/customer/logic/customer_cubit.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';

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

  String? _selectedType;
  String? _selectedPurpose;

  final List<String> propertyTypes = [
    "APARTMENT",
    "VILLA",
    "HOUSE",
    "STUDIO",
    "LAND",
  ];
  final List<String> purposes = ["SALE", "RENT"];

  List<File> selectedImages = [];

  final ImagePicker picker = ImagePicker();

  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage(imageQuality: 80);
    if (pickedFiles.isNotEmpty) {
      setState(() {
        selectedImages.addAll(pickedFiles.map((e) => File(e.path)));
      });
    }
  }

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
      body: BlocConsumer<CustomerRequestCubit, CustomerRequestState>(
        listener: (context, state) {
          if (state is CustomerRequestSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is CustomerRequestError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          bool isLoading = state is CustomerRequestLoading;

          return AbsorbPointer(
            absorbing: isLoading,
            child: SingleChildScrollView(
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
                          onChanged: (val) =>
                              setState(() => _selectedType = val),
                          hintText: "Select property type",
                        ),
                        verticalSpace(12),

                        CustomDropDown(
                          value: _selectedPurpose,
                          itemsList: purposes,
                          onChanged: (val) =>
                              setState(() => _selectedPurpose = val),
                          hintText: "Select purpose",
                        ),
                        verticalSpace(12),

                        AppTextFormField(
                          controller: _descriptionController,
                          hintText: "Description",
                          prefixIcon: const Icon(
                            Icons.description,
                            color: AppColors.darkBeige,
                          ),
                          validator: (v) => v == null || v.isEmpty
                              ? "Enter description"
                              : null,
                        ),
                        verticalSpace(12),

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
                          validator: (v) =>
                              v == null || double.tryParse(v) == null
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
                          validator: (v) =>
                              v == null || double.tryParse(v) == null
                              ? "Enter valid longitude"
                              : null,
                        ),
                        verticalSpace(12),

                        verticalSpace(16),

                        Text("Images", style: TextStyles.font20BlueBold),
                        verticalSpace(12),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: selectedImages.length + 1,
                            itemBuilder: (context, index) {
                              if (index == selectedImages.length) {
                                return GestureDetector(
                                  onTap: pickImages,
                                  child: Container(
                                    width: 100,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                width: 100,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(selectedImages[index].path),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        AppTextButton(
                          buttonText: "Submit request",
                          textStyle: TextStyles.font16WhiteBold,
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;
                            if (_selectedType == null ||
                                _selectedPurpose == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please select type and purpose",
                                  ),
                                ),
                              );
                              return;
                            }

                            final newRequest = CustomerRequest(
                              title: _titleController.text.trim(),
                              type: _selectedType!,
                              purpose: _selectedPurpose!,
                              description: _descriptionController.text.trim(),
                              price: double.parse(_priceController.text.trim()),
                              area: double.parse(_areaController.text.trim()),
                              address: _addressController.text.trim(),

                              latitude: double.parse(
                                _latitudeController.text.trim(),
                              ),
                              longitude: double.parse(
                                _longitudeController.text.trim(),
                              ),
                            );

                            final cubit = context.read<CustomerRequestCubit>();
                            await cubit.createRequest(
                              newRequest,
                              imagePaths: selectedImages
                                  .map((f) => f.path)
                                  .toList(),
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
        },
      ),
    );
  }
}
