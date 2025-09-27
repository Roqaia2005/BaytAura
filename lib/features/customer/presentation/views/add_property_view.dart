import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bayt_aura/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/helpers/image_picker.dart';
import 'package:bayt_aura/core/helpers/app_circular_indicator.dart';
import 'package:bayt_aura/features/customer/logic/customer_state.dart';
import 'package:bayt_aura/features/customer/logic/customer_cubit.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_form_fields.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_form_scaffold.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_images_section.dart';

class AddPropertyView extends StatefulWidget {
  const AddPropertyView({super.key});

  @override
  State<AddPropertyView> createState() => _AddPropertyViewState();
}

class _AddPropertyViewState extends State<AddPropertyView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _areaController = TextEditingController();
  final _addressController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  String? _selectedType;
  String? _selectedPurpose;
  final List<File> selectedImages = [];

  Future<void> _pickImages() async {
    final files = await ImagePickerHelper.pickImages();
    if (files.isNotEmpty) setState(() => selectedImages.addAll(files));
  }

  Future<void> _submitRequest() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate())
      return;
    if (_selectedType == null || _selectedPurpose == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select type and purpose")),
      );
      return;
    }

    final newRequest = CustomerRequest(
      title: _titleController.text.trim(),
      type: _selectedType!,
      purpose: _selectedPurpose!,
      description: _descriptionController.text.trim(),
      price: double.tryParse(_priceController.text.trim()) ?? 0,
      area: double.tryParse(_areaController.text.trim()) ?? 0,
      address: _addressController.text.trim(),
      latitude: double.tryParse(_latitudeController.text.trim()) ?? 0,
      longitude: double.tryParse(_longitudeController.text.trim()) ?? 0,
    );

    await context.read<CustomerRequestCubit>().createRequest(
      newRequest,
      imagePaths: selectedImages.map((f) => f.path).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerRequestCubit, CustomerRequestState>(
      listener: (context, state) {
        if (state is CustomerRequestSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Your request has been submitted"),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is CustomerRequestError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            PropertyFormScaffold(
              formKey: _formKey,
              title: "Add New Property",
              formFields: PropertyFormFields(
                titleController: _titleController,
                descriptionController: _descriptionController,
                priceController: _priceController,
                areaController: _areaController,
                addressController: _addressController,
                latitudeController: _latitudeController,
                longitudeController: _longitudeController,
                selectedType: _selectedType,
                selectedPurpose: _selectedPurpose,
                propertyTypes: propertyTypes,
                purposes: purposes,
                onTypeChanged: (val) => setState(() => _selectedType = val),
                onPurposeChanged: (val) =>
                    setState(() => _selectedPurpose = val),
              ),
              imagesSection: PropertyImagesSection(
                newImages: selectedImages,
                onPickImages: _pickImages,
                onRemoveNew: (i) => setState(() => selectedImages.removeAt(i)),
              ),
              submitButton: AppTextButton(
                buttonText: "Submit Request",
                textStyle: TextStyles.font16WhiteBold,
                onPressed: _submitRequest,
              ),
            ),
            if (state is CustomerRequestLoading)
              Container(
                color: Colors.black38,
                child: const Center(child:  AppCircularIndicator()),
              ),
          ],
        );
      },
    );
  }
}
