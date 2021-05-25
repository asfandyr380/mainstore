import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class SigninViewModel extends ChangeNotifier {
  int counter = 0;
  Navigation _navigation = locator<Navigation>();

  void incrementCounter() {
    counter++;
    notifyListeners();
    // _navigation.navigateTo(SignUp);
  }
}
