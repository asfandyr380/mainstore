import 'package:flutter/material.dart';

class ForumViewModel extends ChangeNotifier {
  bool isTicked = false;

  String name = '';
  String email = '';
  String pass = '';
  String confirm_pass = '';
  String phone = '';

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
