// this project refers to https://github.com/RivaanRanawat/instagram-flutter-clone

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './responsive/mobile_screen_layout.dart';
import './responsive/web_screen_layout.dart';
import './responsive/responsive_layout.dart';
import './utils/colors.dart';
import './screens/login_screen.dart';
import '../screens/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAd04Q95Skc8T3IlzEepV_gyaGB7wD6eZI',
          appId: '1:968196701305:web:dd6a3142ded6ee921fa8a8',
          messagingSenderId: '968196701305',
          projectId: 'rana-academy',
          storageBucket: 'rana-academy.appspot.com'),
    );
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      title: 'Rana Academy',
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: LoginScreen(),
    );
  }
}
