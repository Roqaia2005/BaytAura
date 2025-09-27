import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bayt_aura/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/helpers/image_picker.dart';
import 'package:bayt_aura/core/helpers/app_circular_indicator.dart';
import 'package:bayt_aura/features/property/logic/media_cubit.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_form_fields.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_form_scaffold.dart';
import 'package:bayt_aura/features/property/presentation/widgets/property_images_section.dart';

class EditPropertyView extends StatefulWidget {
  final Property property;
  const EditPropertyView({super.key, required this.property});

  @override
  State<EditPropertyView> createState() => _EditPropertyViewState();
}

class _EditPropertyViewState extends State<EditPropertyView> {
  final _formKey = GlobalKey<FormState>();
  late final _titleController = TextEditingController(
    text: widget.property.title,
  );
  late final _descriptionController = TextEditingController(
    text: widget.property.description,
  );
  late final _priceController = TextEditingController(
    text: widget.property.price?.toString() ?? "",
  );
  late final _areaController = TextEditingController(
    text: widget.property.area?.toString() ?? "",
  );
  late final _addressController = TextEditingController(
    text: widget.property.address,
  );
  late final _latitudeController = TextEditingController(
    text: widget.property.latitude?.toString() ?? "",
  );
  late final _longitudeController = TextEditingController(
    text: widget.property.longitude?.toString() ?? "",
  );

  String? _selectedType;
  String? _selectedPurpose;
  List<File> newImages = [];

  @override
  void initState() {
    super.initState();
    _selectedType = widget.property.type;
    _selectedPurpose = widget.property.purpose;
  }

  Future<void> _pickImages() async {
    final files = await ImagePickerHelper.pickImages();
    if (files.isNotEmpty) setState(() => newImages.addAll(files));
  }

  void _updateProperty() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    if (_selectedType == null || _selectedPurpose == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select type and purpose")),
      );
      return;
    }

    final updated = Property(
      id: widget.property.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.tryParse(_priceController.text.trim()) ?? 0,
      area: double.tryParse(_areaController.text.trim()) ?? 0,
      address: _addressController.text.trim(),
      latitude: double.tryParse(_latitudeController.text.trim()) ?? 0,
      longitude: double.tryParse(_longitudeController.text.trim()) ?? 0,
      type: _selectedType!,
      purpose: _selectedPurpose!,
      images: widget.property.images,
      files: newImages,
    );

    context.read<PropertyCubit>().updateProperty(
      updated,
      newImages.map((f) => f.path).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, state) {
        if (state is PropertyUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Property Updated"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, state.property);
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
              title: "Edit Property",
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
                newImages: newImages,
                oldImages: widget.property.images,
                onPickImages: _pickImages,
                onRemoveNew: (i) => setState(() => newImages.removeAt(i)),
                onRemoveOld: (id) {
                  context.read<MediaCubit>().deleteMedia(
                    widget.property.id!,
                    id,
                  );
                  setState(() {
                    widget.property.images!.removeWhere((e) => e.id == id);
                  });
                },
              ),
              submitButton: AppTextButton(
                buttonText: "Update Property",
                textStyle: TextStyles.font16WhiteBold,
                onPressed: _updateProperty,
              ),
            ),
            if (state is PropertyLoading)
              Container(
                color: Colors.black38,
                child: const Center(child: AppCircularIndicator()),
              ),
          ],
        );
      },
    );
  }
}
