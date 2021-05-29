import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class SigninViewModel extends ChangeNotifier {
  Auth _auth = locator<Auth>();

  Future signInUser(String email, String pass) async {
    print(email);
    print(pass);

    var result = await _auth.signIn(email, pass);
    // if result is bool
    if (result is bool) {
      // if Result is True Then User Successfuly Signed In
      // ToDo: Navigate User to the Home Page
      print(result);
    } else {
      print(result);
      // ToDo: Show Error Msg to the User
    }
  }
}
