import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bayt_aura/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/helpers/image_picker.dart';
import 'package:bayt_aura/core/helpers/app_circular_indicator.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_form_fields.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_form_scaffold.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_images_section.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
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

  void _submitPost() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate())
      return;
    if (_selectedType == null || _selectedPurpose == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select type and purpose")),
      );
      return;
    }

    final newProperty = Property(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.tryParse(_priceController.text.trim()) ?? 0,
      area: double.tryParse(_areaController.text.trim()) ?? 0,
      address: _addressController.text.trim(),
      type: _selectedType!,
      purpose: _selectedPurpose!,
      latitude: double.tryParse(_latitudeController.text.trim()) ?? 0,
      longitude: double.tryParse(_longitudeController.text.trim()) ?? 0,
    );

    context.read<PropertyCubit>().addProperty(
      newProperty,
      selectedImages.map((f) => f.path).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, state) {
        if (state is PropertyAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Property Added"),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is PropertyError) {
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
              title: "Add New Post",
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
                buttonText: "Add Post",
                textStyle: TextStyles.font16WhiteBold,
                onPressed: _submitPost,
              ),
            ),
            if (state is PropertyLoading)
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
