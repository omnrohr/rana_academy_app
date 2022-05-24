import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethod {
  final FirebaseStorage _fireStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List image, bool isPost) async {
    Reference ref =
        _fireStorage.ref().child(childName).child(_auth.currentUser!.uid);
    return await ref.putData(image).then((snap) => snap.ref.getDownloadURL());
  }
}
