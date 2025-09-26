import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bayt_aura/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bayt_aura/core/helpers/spacing.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/helpers/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bayt_aura/features/property/logic/media_cubit.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_state.dart';
import 'package:bayt_aura/features/property/presentation/widgets/edit_appbar.dart';
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

  // Controllers
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
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _selectedType = widget.property.type;
    _selectedPurpose = widget.property.purpose;
  }

  Future<void> _pickImages() async {
    final files = await ImagePickerHelper.pickImages();
    if (files.isNotEmpty) {
      setState(() => newImages.addAll(files));
    }
  }

  void _updateProperty() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedType == null || _selectedPurpose == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select type and purpose")),
      );
      return;
    }

    final updated = Property(
      id: widget.property.id,
      title: _titleController.text.trim(),
      type: _selectedType!,
      purpose: _selectedPurpose!,
      description: _descriptionController.text.trim(),
      price: double.parse(_priceController.text.trim()),
      area: double.parse(_areaController.text.trim()),
      address: _addressController.text.trim(),
      latitude: double.parse(_latitudeController.text.trim()),
      longitude: double.parse(_longitudeController.text.trim()),
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
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocConsumer<PropertyCubit, PropertyState>(
        listener: (context, state) {
          if (state is PropertyUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Property updated successfully"),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is PropertyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return PropertyFormScaffold(
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
              onPurposeChanged: (val) => setState(() => _selectedPurpose = val),
            ),
            imagesSection: PropertyImagesSection(
              newImages: newImages,
              oldImages: widget.property.images,
              onPickImages: () async {
                _pickImages();
              },
              onRemoveNew: (i) => setState(() => newImages.removeAt(i)),
              onRemoveOld: (id) {
                context.read<MediaCubit>().deleteMedia(widget.property.id!, id);
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
          );
        },
      ),
    );
  }
}
