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
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';

class EditPropertyView extends StatefulWidget {
  final Property property;

  const EditPropertyView({super.key, required this.property});

  @override
  State<EditPropertyView> createState() => _EditPropertyViewState();
}

class _EditPropertyViewState extends State<EditPropertyView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _areaController;
  late TextEditingController _addressController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;

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
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.property.title);
    _descriptionController = TextEditingController(
      text: widget.property.description ?? '',
    );
    _priceController = TextEditingController(
      text: widget.property.price?.toString() ?? '',
    );
    _areaController = TextEditingController(
      text: widget.property.area?.toString() ?? '',
    );
    _addressController = TextEditingController(
      text: widget.property.address ?? '',
    );
    _latitudeController = TextEditingController(
      text: widget.property.latitude?.toString() ?? '',
    );
    _longitudeController = TextEditingController(
      text: widget.property.longitude?.toString() ?? '',
    );
    _selectedType = widget.property.type;
    _selectedPurpose = widget.property.purpose;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _areaController.dispose();
    _addressController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    final pickedFiles = await _picker.pickMultiImage(imageQuality: 80);
    if (pickedFiles.isNotEmpty) {
      setState(() {
        selectedImages.addAll(pickedFiles.map((e) => File(e.path)));
      });
    }
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedType == null || _selectedPurpose == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select type and purpose")),
      );
      return;
    }

    final updatedProperty = Property(
      id: widget.property.id,
      title: _titleController.text,
      description: _descriptionController.text,
      price: double.tryParse(_priceController.text),
      area: double.tryParse(_areaController.text),
      address: _addressController.text,
      type: _selectedType!,
      purpose: _selectedPurpose!,
      latitude: double.tryParse(_latitudeController.text),
      longitude: double.tryParse(_longitudeController.text),
    );

    context.read<PropertyCubit>().updateProperty(updatedProperty);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, state) {
        if (state is PropertyUpdated) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Property Updated!")));
          Navigator.pop(context, state.property); // return updated property
        }
      },
      builder: (context, state) {
        if (state is PropertyLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.blue),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColors.blue,
            title: Text("Edit Property", style: TextStyles.font24WhiteBold),
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
                      // Property info section
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
                        onChanged: (v) => setState(() => _selectedType = v),
                        hintText: "Select property type",
                      ),
                      verticalSpace(12),
                      CustomDropDown(
                        value: _selectedPurpose,
                        itemsList: purposes,
                        onChanged: (v) => setState(() => _selectedPurpose = v),
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
                        validator: (v) =>
                            v == null || v.isEmpty ? "Enter description" : null,
                      ),
                      verticalSpace(20),
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
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(selectedImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
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
                            v == null || v.isEmpty || double.tryParse(v) == null
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
                            v == null || v.isEmpty || double.tryParse(v) == null
                            ? "Enter valid longitude"
                            : null,
                      ),
                      verticalSpace(12),
                      AppTextButton(
                        buttonText: "Save Changes",
                        textStyle: TextStyles.font16WhiteBold,
                        onPressed: _saveChanges,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
