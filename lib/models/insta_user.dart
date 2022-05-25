import 'package:cloud_firestore/cloud_firestore.dart';

class InstaUser {
  final String email;
  final String uid;
  final String imageUrl;
  final String userName;
  final String bio;
  final List followers;
  final List following;

  InstaUser(
      {required this.userName,
      required this.uid,
      required this.imageUrl,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following});

  static InstaUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return InstaUser(
      userName: snapshot["userName"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      imageUrl: snapshot["imageUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "uid": uid,
        "email": email,
        "imageUrl": imageUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
