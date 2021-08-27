import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Api/Auth/Auth_Services.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthServicesApi _api = locator<AuthServicesApi>();
  Navigation _navigation = locator<Navigation>();
  DialogService _alertDialog = locator<DialogService>();
  bool isLoading = false;
  String oldPass = '';
  String newPass = '';
  String confirmPass = '';
  String email = '';

  setBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Password';
    } else if (value.length < 6) {
      return 'Password Can\'t be less Then 6 Characters';
    }
  }

  validateConfirmPass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Password';
    } else if (confirmPass != newPass) {
      return 'Your Password Does Not Match';
    }
  }

  validateInputs() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return 1;
    } else {
      autovalidateMode = AutovalidateMode.onUserInteraction;
      notifyListeners();
    }
  }

  Future submit() async {
    var res = validateInputs();
    if (res == 1) {
      setBusy(true);
      var map = {"oldPassword": oldPass, "password": newPass};
      var result = await _api.forgotPassword(email, map);
      print('reuslt ==> $result');
      if (result == 1) {
        print('reuslt ==> $result');
        return true;
      } else {
        _alertDialog.showDialog(
            title: 'Authentication Error',
            description: res,
            buttonTitle: "Close");
        setBusy(false);
      }
    }
  }

  redirectBack() {
    _navigation.pushReplaceRoute(SigninPage());
  }
}
