import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class SigninViewModel extends ChangeNotifier {
  Auth _auth = locator<Auth>();
  DialogService _alertDialog = locator<DialogService>();

  Future signInUser(String email, String pass) async {
    print(email);
    print(pass);

    var result = await _auth.signIn(email, pass);
    // if result is bool
    if (result is bool) {
      // if Result is True Then User Successfuly Signed In
      // ToDo: Navigate User to the Home Page
      print(result);
      return !result;
    } else {
      print(result);
      _alertDialog.showDialog(
          title: 'Authentication Error',
          description: result,
          buttonTitle: "Close");
      return false;
    }
  }
}
