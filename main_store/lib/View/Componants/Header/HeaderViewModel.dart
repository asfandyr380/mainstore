import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class HeaderViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();

  onDropDownChange(var newValue, var dropDownVal) {
    dropDownVal = newValue!;
    notifyListeners();
  }

  navigateToSignInLogInPage(bool isSignIn) {
    if (isSignIn) {
      _navigation.navigateTo(SignUp);
    } else {
      _navigation.navigateTo(SignIn);
    }
  }
}
