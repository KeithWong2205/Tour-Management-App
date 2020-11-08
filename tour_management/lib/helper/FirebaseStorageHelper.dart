import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageHelper {

  static Future<String> pickAndUploadImage({String filename, int quality, ImageSource source = ImageSource.gallery}) async {
    File file = await pickImage(quality: quality, source: source);
    if (file != null) {
      return await uploadImage(file: file, filename: filename);
    }
    return null;
  }

  static Future<File> pickImage({int quality = 100, ImageSource source = ImageSource.gallery}) async {
    PickedFile pickedFile = await ImagePicker().getImage(imageQuality: quality, source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<String> uploadImage({File file, String filename}) async {
    if (filename == null || filename.isEmpty) {
      filename = DateTime.now().millisecondsSinceEpoch.toString();
    }
    Reference reference = FirebaseStorage.instance.ref().child("images/$filename.jpg");
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => {});
    return await downloadUrl.ref.getDownloadURL();
  }

}