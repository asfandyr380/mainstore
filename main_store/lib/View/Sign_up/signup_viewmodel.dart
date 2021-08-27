import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Api/Auth/Auth_Services.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/View/AccountVerification/AccountVerification.dart';
import 'package:main_store/View/Home/HomeView.dart';

class SignupViewModel extends ChangeNotifier {
  DialogService _alertDialog = locator<DialogService>();
  Navigation _navigation = locator<Navigation>();
  AuthServicesApi _authApi = locator<AuthServicesApi>();
  bool isCheck = false;
  bool isLoading = false;

  navigateToLoginPage() {
    _navigation.navigateTo(SignIn);
  }

  accepttermsandCondition(bool state) async {
    isCheck = state;
    notifyListeners();
  }

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  signUp(String username, email, phone, password, confirmPass, address, city,
      postalCode) async {
    isBusy(true);
    if (password == confirmPass) {
      var result = await _authApi.createNewUser(
          username, email, phone, password, address, city, postalCode);
      if (result is bool) {
        _navigation.pushReplaceRoute(AccountVerificationView());
      } else {
        _alertDialog.showDialog(
            title: 'Authentication Error',
            description: result,
            buttonTitle: "Close");
      }
    } else {
      _alertDialog.showDialog(
          title: 'Password is Not Correct',
          description: 'Confirm Password Does Not Match',
          buttonTitle: "Close");
    }

    isBusy(false);
  }
}
