import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bayt_aura/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bayt_aura/core/widgets/app_button.dart';
import 'package:bayt_aura/core/theming/text_styles.dart';
import 'package:bayt_aura/core/helpers/image_picker.dart';
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
    if (_formKey.currentState == null || !_formKey.currentState!.validate())
      return;
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
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      },
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:bayt_aura/core/theming/colors.dart';
// import 'package:bayt_aura/core/helpers/spacing.dart';
// import 'package:bayt_aura/core/widgets/app_button.dart';
// import 'package:bayt_aura/core/theming/text_styles.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:bayt_aura/core/widgets/custom_drop_down.dart';
// import 'package:bayt_aura/core/widgets/app_text_form_field.dart';
// import 'package:bayt_aura/features/property/logic/media_cubit.dart';
// import 'package:bayt_aura/features/property/data/models/property.dart';
// import 'package:bayt_aura/features/property/logic/property_cubit.dart';
// import 'package:bayt_aura/features/property/logic/property_state.dart';

// class EditPropertyView extends StatefulWidget {
//   final Property property;
//   const EditPropertyView({super.key, required this.property});

//   @override
//   State<EditPropertyView> createState() => _EditPropertyViewState();
// }

// class _EditPropertyViewState extends State<EditPropertyView> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   late TextEditingController _titleController;
//   late TextEditingController _descriptionController;
//   late TextEditingController _priceController;
//   late TextEditingController _areaController;
//   late TextEditingController _addressController;
//   late TextEditingController _latitudeController;
//   late TextEditingController _longitudeController;

//   String? _selectedType;
//   String? _selectedPurpose;

//   final List<String> propertyTypes = [
//     "APARTMENT",
//     "VILLA",
//     "HOUSE",
//     "STUDIO",
//     "LAND",
//   ];
//   final List<String> purposes = ["SALE", "RENT"];

//   // الصور الجديدة
//   List<File> newImages = [];
//   final ImagePicker picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     final p = widget.property;
//     _titleController = TextEditingController(text: p.title);
//     _descriptionController = TextEditingController(text: p.description);
//     _priceController = TextEditingController(text: p.price?.toString() ?? "");
//     _areaController = TextEditingController(text: p.area?.toString() ?? "");
//     _addressController = TextEditingController(text: p.address);
//     _latitudeController = TextEditingController(
//       text: p.latitude?.toString() ?? "",
//     );
//     _longitudeController = TextEditingController(
//       text: p.longitude?.toString() ?? "",
//     );

//     _selectedType = p.type;
//     _selectedPurpose = p.purpose;
//   }

//   Future<void> pickImages() async {
//     final pickedFiles = await picker.pickMultiImage(imageQuality: 80);
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         newImages.addAll(pickedFiles.map((e) => File(e.path)));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: AppColors.blue,
//         title: Text("Edit Property", style: TextStyles.font24WhiteBold),
//       ),
//       body: BlocConsumer<PropertyCubit, PropertyState>(
//         listener: (context, state) {
//           if (state is PropertyUpdated) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Property updated successfully")),
//             );
//             Navigator.pop(context, state.property);
//           } else if (state is PropertyError) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(state.message)));
//           }
//         },
//         builder: (context, state) {
//           final isLoading = state is PropertyLoading;

//           return AbsorbPointer(
//             absorbing: isLoading,
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(20.sp),
//               child: Card(
//                 elevation: 6,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(20.sp),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Property Info", style: TextStyles.font20BlueBold),
//                         verticalSpace(16),

//                         AppTextFormField(
//                           controller: _titleController,
//                           hintText: "Title",
//                           prefixIcon: const Icon(
//                             Icons.title,
//                             color: AppColors.darkBeige,
//                           ),
//                           validator: (v) =>
//                               v == null || v.isEmpty ? "Enter title" : null,
//                         ),
//                         verticalSpace(12),

//                         CustomDropDown(
//                           value: _selectedType,
//                           itemsList: propertyTypes,
//                           onChanged: (val) =>
//                               setState(() => _selectedType = val),
//                           hintText: "Select property type",
//                         ),
//                         verticalSpace(12),

//                         CustomDropDown(
//                           value: _selectedPurpose,
//                           itemsList: purposes,
//                           onChanged: (val) =>
//                               setState(() => _selectedPurpose = val),
//                           hintText: "Select purpose",
//                         ),
//                         verticalSpace(12),

//                         AppTextFormField(
//                           controller: _descriptionController,
//                           hintText: "Description",
//                           prefixIcon: const Icon(
//                             Icons.description,
//                             color: AppColors.darkBeige,
//                           ),
//                           validator: (v) => v == null || v.isEmpty
//                               ? "Enter description"
//                               : null,
//                         ),
//                         verticalSpace(12),

//                         AppTextFormField(
//                           controller: _priceController,
//                           hintText: "Price",
//                           keyboardType: TextInputType.number,
//                           prefixIcon: const Icon(
//                             Icons.attach_money,
//                             color: AppColors.darkBeige,
//                           ),
//                           validator: (v) =>
//                               v == null || v.isEmpty ? "Enter price" : null,
//                         ),
//                         verticalSpace(12),

//                         AppTextFormField(
//                           controller: _areaController,
//                           hintText: "Area (sq ft)",
//                           keyboardType: TextInputType.number,
//                           prefixIcon: const Icon(
//                             Icons.square_foot,
//                             color: AppColors.darkBeige,
//                           ),
//                           validator: (v) =>
//                               v == null || v.isEmpty ? "Enter area" : null,
//                         ),
//                         verticalSpace(12),

//                         AppTextFormField(
//                           controller: _addressController,
//                           hintText: "Address",
//                           prefixIcon: const Icon(
//                             Icons.location_on,
//                             color: AppColors.darkBeige,
//                           ),
//                           validator: (v) =>
//                               v == null || v.isEmpty ? "Enter address" : null,
//                         ),
//                         verticalSpace(12),

//                         AppTextFormField(
//                           controller: _latitudeController,
//                           hintText: "Latitude",
//                           keyboardType: TextInputType.number,
//                           prefixIcon: const Icon(
//                             Icons.explore,
//                             color: AppColors.darkBeige,
//                           ),
//                           validator: (v) =>
//                               v == null || double.tryParse(v) == null
//                               ? "Enter valid latitude"
//                               : null,
//                         ),
//                         verticalSpace(12),

//                         AppTextFormField(
//                           controller: _longitudeController,
//                           hintText: "Longitude",
//                           keyboardType: TextInputType.number,
//                           prefixIcon: const Icon(
//                             Icons.explore_outlined,
//                             color: AppColors.darkBeige,
//                           ),
//                           validator: (v) =>
//                               v == null || double.tryParse(v) == null
//                               ? "Enter valid longitude"
//                               : null,
//                         ),
//                         verticalSpace(16),

//                         Text("Images", style: TextStyles.font20BlueBold),
//                         verticalSpace(12),

//                         // جوه ListView بتاع الصور
//                         SizedBox(
//                           height: 100,
//                           child: ListView(
//                             scrollDirection: Axis.horizontal,
//                             children: [
//                               // الصور القديمة من السيرفر
//                               // الصور القديمة من السيرفر
//                               ...?widget.property.images?.map(
//                                 (img) => Stack(
//                                   children: [
//                                     Container(
//                                       width: 100,
//                                       margin: const EdgeInsets.symmetric(
//                                         horizontal: 4,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         image: DecorationImage(
//                                           image: NetworkImage(img.url ?? ""),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     // زر الحذف
//                                     Positioned(
//                                       right: 0,
//                                       top: 0,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           context
//                                               .read<MediaCubit>()
//                                               .deleteMedia(
//                                                 widget.property.id!,
//                                                 img.id!,
//                                               );
//                                           setState(() {
//                                             widget.property.images!.removeWhere(
//                                               (e) => e.id == img.id,
//                                             );
//                                           });
//                                         },
//                                         child: Container(
//                                           decoration: const BoxDecoration(
//                                             color: Colors.black54,
//                                             shape: BoxShape.circle,
//                                           ),
//                                           padding: const EdgeInsets.all(4),
//                                           child: const Icon(
//                                             Icons.close,
//                                             color: Colors.white,
//                                             size: 18,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               // الصور الجديدة (قبل الرفع)
//                               ...newImages.map(
//                                 (file) => Stack(
//                                   children: [
//                                     Container(
//                                       width: 100,
//                                       margin: const EdgeInsets.symmetric(
//                                         horizontal: 4,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         image: DecorationImage(
//                                           image: FileImage(file),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     // زر unselect
//                                     Positioned(
//                                       right: 0,
//                                       top: 0,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           setState(() {
//                                             newImages.remove(file);
//                                           });
//                                         },
//                                         child: Container(
//                                           decoration: const BoxDecoration(
//                                             color: Colors.black54,
//                                             shape: BoxShape.circle,
//                                           ),
//                                           padding: const EdgeInsets.all(4),
//                                           child: const Icon(
//                                             Icons.close,
//                                             color: Colors.white,
//                                             size: 18,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               // زر الإضافة
//                               GestureDetector(
//                                 onTap: pickImages,
//                                 child: Container(
//                                   width: 100,
//                                   margin: const EdgeInsets.symmetric(
//                                     horizontal: 4,
//                                   ),
//                                   color: Colors.grey[300],
//                                   child: const Icon(
//                                     Icons.add_a_photo,
//                                     size: 40,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         AppTextButton(
//                           buttonText: "Update Property",
//                           textStyle: TextStyles.font16WhiteBold,
//                           onPressed: () async {
//                             if (!_formKey.currentState!.validate()) return;
//                             if (_selectedType == null ||
//                                 _selectedPurpose == null) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                     "Please select type and purpose",
//                                   ),
//                                 ),
//                               );
//                               return;
//                             }

//                             final updated = Property(
//                               id: widget.property.id,
//                               title: _titleController.text.trim(),
//                               type: _selectedType!,
//                               purpose: _selectedPurpose!,
//                               description: _descriptionController.text.trim(),
//                               price: double.parse(_priceController.text.trim()),
//                               area: double.parse(_areaController.text.trim()),
//                               address: _addressController.text.trim(),
//                               latitude: double.parse(
//                                 _latitudeController.text.trim(),
//                               ),
//                               longitude: double.parse(
//                                 _longitudeController.text.trim(),
//                               ),
//                               images: widget.property.images,
//                               files: newImages, // الملفات الجديدة
//                             );

//                             context.read<PropertyCubit>().updateProperty(
//                               updated,
//                               newImages
//                                   .map((f) => f.path)
//                                   .toList(), // هنا التعديل
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
