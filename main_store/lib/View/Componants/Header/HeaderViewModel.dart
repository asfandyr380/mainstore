import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Fireabase/Firestore/cart_services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class HeaderViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();
  Auth _auth = locator<Auth>();
  CartServices _cart = locator<CartServices>();
  bool userLogedIn = false;
  int cartCount = 0;
  getCount() async {
    var _userIp = await Ipify.ipv4();
    var _user = await _auth.currrentUser();
    if (_user) {
      var userId = await _auth.getUserId();
      var count = await _cart.getCartCount(userId);
      cartCount = count;
      notifyListeners();
    } else {
      var count = await _cart.getCartCount(_userIp);
      cartCount = count;
      notifyListeners();
    }
  }

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

  navigateToAbout() {
    _navigation.navigateTo(AboutUs);
  }

  navigateToHome() {
    _navigation.navigateTo(HomeView);
  }

  navigateToContact() {
    _navigation.navigateTo(ContactUs);
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
