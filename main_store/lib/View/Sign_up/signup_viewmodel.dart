import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';

class SignupViewModel extends ChangeNotifier {
  Auth _auth = locator<Auth>();

  Future createNewUser(
      String email, String pass, String name, String phone) async {
    var result = await _auth.signUp(email, pass, name, phone);
    // if Result is a bool
    if (result is bool) {
      if (result) {
        // if Result is True Then User Successfuly Signed Up
        // TODO: Navigate User to the Home Page
      }
    }
    // else Result is a String which Probebly is an Exception
    else {
      // TODO: Show Error Msg to the User
    }
  }
}
