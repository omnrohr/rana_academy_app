import 'package:flutter/foundation.dart';
import '../resources/auth_methods.dart';
import '../models/insta_user.dart';

class UserProvider extends ChangeNotifier {
  InstaUser? _instaUser;
  final AuthMethods _authMethods = AuthMethods();

  InstaUser get getInstaUser => _instaUser!;

  Future<void> refreshInstaUser() async {
    InstaUser user = await _authMethods.getUserDetails();
    _instaUser = user;
    notifyListeners();
  }
}
