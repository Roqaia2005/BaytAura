import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<List<File>> pickImages({int quality = 80}) async {
    final pickedFiles = await _picker.pickMultiImage(imageQuality: quality);
    return pickedFiles.map((e) => File(e.path)).toList();
  }
}
