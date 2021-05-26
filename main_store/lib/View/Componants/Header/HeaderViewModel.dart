import 'package:flutter/material.dart';

class HeaderViewModel extends ChangeNotifier {
  onDropDownChange(var newValue, var dropDownVal) {
    dropDownVal = newValue!;
    notifyListeners();
  }
}
