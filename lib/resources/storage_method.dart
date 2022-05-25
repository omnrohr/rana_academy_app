import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  final FirebaseStorage _fireStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List image, bool isPost) async {
    Reference ref =
        _fireStorage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String postId = const Uuid().v1();
      ref = ref.child(postId);
    }

    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    // return await ref.putData(image).then((snap) => snap.ref.getDownloadURL());
    return downloadUrl;
  }
}
