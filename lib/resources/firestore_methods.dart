import 'dart:typed_data';
import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rana_academy/models/posts.dart';
import 'package:rana_academy/resources/storage_method.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(Uint8List image, String description, String userId,
      String userName, String profileImage) async {
    String res = 'Some error occurred';
    try {
      String imageUrl =
          await StorageMethod().uploadImageToStorage('posts', image, true);

      String postId = Uuid().v1();
      Post post = Post(
          userName: userName,
          uid: userId,
          datePublished: DateTime.now(),
          description: description,
          postId: postId,
          postUrl: imageUrl,
          profileImage: profileImage,
          likes: []);

      await _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> likePost(String postId, String userId, List likes) async {
    try {
      if (likes.contains(userId)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([userId]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([userId]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> postComment(String postId, String comment, String userId,
      String userName, String userProfile) async {
    String res = 'Some error occurred';

    try {
      if (comment.isEmpty) {
        res = 'Please add a comment';
        return res;
      }
      String commentId = Uuid().v1();
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set({
        'userProfile': userProfile,
        'userName': userName,
        'userId': userId,
        'publishDate': DateTime.now(),
        'comment': comment,
      });
      res = 'Posted';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
