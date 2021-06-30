import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Api/Auth/Auth_Services.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/View/Home/HomeView.dart';

class SignupViewModel extends ChangeNotifier {
  DialogService _alertDialog = locator<DialogService>();
  Navigation _navigation = locator<Navigation>();
  AuthServicesApi _authApi = locator<AuthServicesApi>();

  navigateToLoginPage() {
    _navigation.navigateTo(SignIn);
  }

  Future signUp(String username, email, phone, password) async {
    var result = await _authApi.createNewUser(username, email, phone, password);
    if (result is bool) {
      _navigation.pushReplaceRoute(Home());
    } else {
      _alertDialog.showDialog(
          title: 'Authentication Error',
          description: result,
          buttonTitle: "Close");
    }
  }
}
