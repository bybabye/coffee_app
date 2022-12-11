import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadFileToStorage({
    required String name,
    required File file,
    required String id,
  }) async {
    String idMessage = const Uuid().v1();
    Reference ref = storage.ref().child(name).child(id).child(idMessage);
    Uint8List bytes = file.readAsBytesSync();
    UploadTask uploadTask = ref.putData(bytes);

    TaskSnapshot snap = await uploadTask;

    String dowloadURL = await snap.ref.getDownloadURL();

    return dowloadURL;
  }
}
