import 'package:flutter/material.dart';

class DropDownViewModel extends ChangeNotifier {
  String currentValue = 'Low to High';

  onChange(String dropDownVal, String newVal) {
    dropDownVal = newVal;
    currentValue = dropDownVal;
    notifyListeners();
    return dropDownVal;
  }
}
