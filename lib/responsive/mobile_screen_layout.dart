// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rana_academy/models/insta_user.dart';
import 'package:rana_academy/providers/user_provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // String userName = '';
  // @override
  // void initState() {
  //   super.initState();
  //   _getUserName();
  // }

  // void _getUserName() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     userName = (snap.data() as Map<String, dynamic>)['userName'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    InstaUser user = Provider.of<UserProvider>(context).getInstaUser;
    return Scaffold(
      body: Center(
        child: Text(user.userName),
      ),
    );
  }
}
