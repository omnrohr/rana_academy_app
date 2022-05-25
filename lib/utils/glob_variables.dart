import 'package:flutter/material.dart';

import '../screens/add_post_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  // const FeedScreen(),
  // const SearchScreen(),
  const Center(child: Text('home')),
  const Center(child: Text('search')),
  const AddPostScreen(),
  const Center(child: Text('notification')),
  const Center(child: Text('profile')),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
];
