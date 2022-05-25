import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final DateTime datePublished;
  final String userName;
  final String postId;
  final String postUrl;
  final String profileImage;
  final likes;

  Post(
      {required this.userName,
      required this.uid,
      required this.datePublished,
      required this.description,
      required this.postId,
      required this.postUrl,
      required this.profileImage,
      required this.likes});

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      userName: snapshot["userName"],
      uid: snapshot["uid"],
      description: snapshot["description"],
      datePublished: snapshot["datePublished"],
      postId: snapshot["postId"],
      postUrl: snapshot["postUrl"],
      profileImage: snapshot["profileImage"],
      likes: snapshot['likes'],
    );
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "uid": uid,
        "description": description,
        "datePublished": datePublished,
        "postId": postId,
        "postUrl": postUrl,
        "profileImage": profileImage,
        "likes": likes,
      };
}
