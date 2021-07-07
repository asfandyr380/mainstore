import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/SummeryModel.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/View/SuccessPage/successPage.dart';

class SummeryViewModel extends ChangeNotifier {
  bool isChecked = false;
  Navigation _navigation = locator<Navigation>();

  changeState(state) {
    isChecked = state;
    notifyListeners();
  }

  navigateToCheckOut(double total, double subTotal, double shipping) {
    var m = SummeryModel.mapData(subTotal, shipping, total);
    _navigation.navigateTo(Checkout, arguments: m);
  }

  navigateToSuccess() {
    _navigation.pushReplaceRoute(Success());
  }
}
