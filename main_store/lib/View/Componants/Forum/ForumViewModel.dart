import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Api/Auth/Auth_Services.dart';

class ForumViewModel extends ChangeNotifier {
  bool isTicked = false;
  bool isLoading = false;
  String name = '';
  String email = '';
  String pass = '';
  String confirm_pass = '';
  String phone = '';
  AuthServicesApi _api = locator<AuthServicesApi>();

  validateForum(String? forumValue) {
    // ignore: unnecessary_null_comparison
    if (forumValue == null || forumValue.isEmpty) {
      return 'This Field Cannot Be Empty';
    }
  }

  googleSignIn() async {
    await _api.authenticateWithGoogle();
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
