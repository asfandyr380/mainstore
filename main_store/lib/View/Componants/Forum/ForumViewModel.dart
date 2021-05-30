import 'package:flutter/material.dart';

class ForumViewModel extends ChangeNotifier {
  bool isTicked = false;
  bool isLoading = false;
  String name = '';
  String email = '';
  String pass = '';
  String confirm_pass = '';
  String phone = '';

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
