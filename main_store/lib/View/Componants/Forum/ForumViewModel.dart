import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Api/Auth/Auth_Services.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/View/Home/home_view.dart';

class ForumViewModel extends ChangeNotifier {
  bool isTicked = false;
  bool isLoading = false;
  String name = '';
  String email = '';
  String pass = '';
  String confirm_pass = '';
  String phone = '';
  String address = '';
  String city = '';
  String postal_code = '';
  AuthServicesApi _api = locator<AuthServicesApi>();
  Navigation _navigation = locator<Navigation>();
  DialogService _alertDialog = locator<DialogService>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  validateForum(String? forumValue, String fieldName) {
    // ignore: unnecessary_null_comparison
    if (forumValue == null || forumValue.isEmpty) {
      return '$fieldName Field Cannot Be Empty';
    }
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
    } else if (confirm_pass != pass) {
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

  navigateToSignUp() {
    _navigation.navigateTo(SignUp);
  }

  googleSignIn(bool isSignIn) async {
    var result = await _api.googleLogin();
    if (isSignIn) {
      if (result is GoogleSignInAccount) {
        String _googleEmail = result.email;
        var res = await _api.loginWithGoogle(_googleEmail);
        if (res is bool) {
          _navigation.pushReplaceRoute(HomePage());
        } else {
          _alertDialog.showDialog(
              title: 'Authentication Error',
              description: res,
              buttonTitle: "Close");
        }
      }
    } else {
      if (result is GoogleSignInAccount) {
        usernameController.text = result.displayName!;
        emailController.text = result.email;
      }
    }
  }

  facebookAuth(bool isSignIn) async {
    var result = await _api.facebookLogin();

    if (result != 0) {
      if (isSignIn) {
        if (result is Map<String, dynamic>) {
          String _facebookEmail = result['email'];
          var res = await _api.loginWithGoogle(_facebookEmail);
          if (res is bool) {
            _navigation.pushReplaceRoute(HomePage());
          } else {
            _alertDialog.showDialog(
                title: 'Authentication Error',
                description: res,
                buttonTitle: "Close");
          }
        }
      } else {
        if (result is Map<String, dynamic>) {
          usernameController.text = result['name']!;
          emailController.text = result['email'];
          notifyListeners();
        }
      }
    }
  }

  navigateToForgotPasswordPage() {
    _navigation.navigateTo(ForgotPassword);
  }

  isBusy(bool loadingState) {
    if (isLoading) {
      isLoading = loadingState;
      notifyListeners();
    } else {
      isLoading = loadingState;
      notifyListeners();
    }
  }

  checkTick() {
    if (isTicked) {
      isTicked = false;
      notifyListeners();
    } else {
      isTicked = true;
      notifyListeners();
    }
  }
}
