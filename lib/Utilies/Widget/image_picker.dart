import 'package:image_picker/image_picker.dart';

class ImagePickerModule {
  String path = '';

  Future<String> pickImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    try {
      XFile? imagePath = await picker.pickImage(source: source);
      if (imagePath == null) return path;
      path = imagePath.path;
      return path;
    } catch (e) {
      rethrow;
    }
  }
}
