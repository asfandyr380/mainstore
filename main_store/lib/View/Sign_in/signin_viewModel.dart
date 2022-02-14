import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Api/Auth/Auth_Services.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/View/Home/home_view.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';

class SigninViewModel extends ChangeNotifier {
  DialogService _alertDialog = locator<DialogService>();
  Navigation _navigation = locator<Navigation>();
  AuthServicesApi _authApi = locator<AuthServicesApi>();
  bool isLoading = false;

  navigateToSignUpPage() {
    _navigation.navigateTo(SignUp);
  }

  isBusy(bool state) async {
    isLoading = state;
    notifyListeners();
  }

  Future logInUser(String email, String password) async {
    isBusy(true);
    var result = await _authApi.logIn(email, password);
    if (result is bool) {
      _navigation.pushReplaceRoute(HomePage());
    } else {
      _alertDialog.showDialog(
          title: 'Authentication Error',
          description: result,
          buttonTitle: "Close");
    }
    isBusy(false);
  }
}
