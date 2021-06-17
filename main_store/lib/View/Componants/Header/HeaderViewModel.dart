import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class HeaderViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();
  Auth _auth = locator<Auth>();
  bool userLogedIn = false;

  onDropDownChange(var newValue, var dropDownVal) {
    dropDownVal = newValue!;
    notifyListeners();
  }

  // Signout Current User
  signoutUser() async {
    await _auth.signOut().then(
          (value) => getUser(),
        );
  }

  Future<bool> getUser() async {
    bool result = await _auth.currrentUser();
    if (result) {
      userLogedIn = result;
      notifyListeners();
    } else {
      userLogedIn = result;
      notifyListeners();
    }
    return userLogedIn;
  }

  navigateToCart() {
    _navigation.navigateTo(Cart);
  }

  navigateToSignInLogInPage(bool isSignIn) {
    if (isSignIn) {
      _navigation.navigateTo(SignUp);
    } else {
      _navigation.navigateTo(SignIn);
    }
  }
}
