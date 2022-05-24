import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import './storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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
      String imageUrl = await StorageMethod()
          .uploadImageToStorage('userImages', imageFile, false);
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _fireStore.collection('users').doc(userCred.user!.uid).set({
        'userName': userName,
        'userId': userCred.user!.uid,
        'email': email,
        'bio': bio,
        'imageUrl': imageUrl,
        'followers': [],
        'following': [],
      });
      print(userCred.user!.uid);

      //difference between set and add

      // await _fireStore.collection('users').add({
      //   'userName': userName,
      //   'userId': userCred.user!.uid,
      //   'email': email,
      //   'bio': bio,
      //   'followers': [],
      //   'following': [],
      // });
      res = 'Success';
    } on FirebaseAuthException catch (e) {
      res = (e.message as String);
    } on PlatformException catch (e) {
      res = (e.message as String) + res;
    } catch (e) {
      res = e.toString();
    }
    print(res);
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
