import 'package:flutter/material.dart';

class DropDownViewModel extends ChangeNotifier {
  String dropDownVal = 'Low to High';

  Future<String> onChange(String newVal) async {
    dropDownVal = newVal;
    notifyListeners();
    return dropDownVal;
  }
}
