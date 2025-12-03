import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  /// Pick single image
  static Future<File?> pickSingleImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);

    if (result == null || result.files.isEmpty) return null;
    return File(result.files.first.path!);
  }

  /// Pick multiple images (gallery)
  static Future<List<File>> pickMultipleImages() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);

    if (result == null || result.files.isEmpty) return [];
    return result.files.map((e) => File(e.path!)).toList();
  }
}
