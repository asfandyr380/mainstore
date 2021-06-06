import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/View/Home/HomeView.dart';

class SignupViewModel extends ChangeNotifier {
  Auth _auth = locator<Auth>();
  DialogService _alertDialog = locator<DialogService>();
  Navigation _navigation = locator<Navigation>();

  navigateToLoginPage() {
    _navigation.navigateTo(SignIn);
  }

  Future createNewUser(
      String email, String pass, String name, String phone) async {
    var result = await _auth.signUp(email, pass, name, phone);
    // if Result is a bool
    if (result is bool) {
      if (result) {
        // if Result is True Then User Successfuly Signed Up
        _navigation.pushReplaceRoute(Home());
        print(result);
        return !result;
      }
    }
    // else Result is a String which Probebly is an Exception
    else {
      print(result);
      _alertDialog.showDialog(
          title: 'Authentication Error',
          description: result,
          buttonTitle: "Close");
      return false;
    }
  }
}
