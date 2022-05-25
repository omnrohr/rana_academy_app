import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rana_academy/models/insta_user.dart';

import './storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<InstaUser> getUserDetails() async {
    User currUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _fireStore.collection('users').doc(currUser.uid).get();
    return InstaUser.fromSnap(snapshot);
  }

  Future<String> signUpUser(
      {required String userName,
      required String password,
      required String email,
      required Uint8List? imageFile,
      required String bio}) async {
    String res = 'Some error occurred';
    try {
      if (userName.isEmpty ||
          password.isEmpty ||
          email.isEmpty ||
          bio.isEmpty ||
          imageFile == null) {
        res = 'Please fill all fields';
        return res;
      }
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String imageUrl = await StorageMethod()
          .uploadImageToStorage('userImages', imageFile, false);

      InstaUser instaUser = InstaUser(
          userName: userName,
          uid: userCred.user!.uid,
          imageUrl: imageUrl,
          email: email,
          bio: bio,
          followers: [],
          following: []);

      await _fireStore
          .collection('users')
          .doc(userCred.user!.uid)
          .set(instaUser.toJson());

      //difference between set and add

      // await _fireStore.collection('users').add({
      //   'userName': userName,
      //   'userId': userCred.user!.uid,
      //   'email': email,
      //   'bio': bio,
      //   'followers': [],
      //   'following': [],
      // });
      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = (e.message as String);
    } on PlatformException catch (e) {
      res = (e.message as String) + res;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> signInUser(String email, String password) async {
    String res = 'Some error occurred';
    try {
      if (email.isEmpty || password.isEmpty) {
        res = 'Please fill all fields';
        return res;
      }
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
