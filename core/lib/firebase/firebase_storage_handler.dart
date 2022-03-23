import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHandler {
  static Future<String>? uploadFile(
      {required String fileNameDisplayInServer, required File file}) async {
    var urlFile = '';
    try {
      final ref = FirebaseStorage.instance.ref(fileNameDisplayInServer);
      var task = ref.putFile(file);
      if (task != null) {
        final snapshot = await task.whenComplete(() => null);
        urlFile = await snapshot.ref.getDownloadURL();
      }
      return urlFile;
    } on FirebaseException catch (e) {
      return '';
    }
  }
}
