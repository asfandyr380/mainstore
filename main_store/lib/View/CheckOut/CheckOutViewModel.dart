import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/SummeryModel.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';
import 'package:main_store/View/SuccessPage/successPage.dart';

class CheckOutViewModel extends ChangeNotifier {
  CartService _cartService = locator<CartService>();
  StorageServices _services = locator<StorageServices>();
  Navigation _navigation = locator<Navigation>();

  bool isLoading = false;

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  navigateToSuccess() {
    _navigation.pushReplaceRoute(Success());
  }

  checkout(SummeryModel m) async {
    isBusy(true);
    var user = await _services.getUser();
    var _userIp = await Ipify.ipv4();
    String i = _userIp.replaceAll('.', '');
    String newI = i.substring(i.length - 5);
    int ip = int.parse(newI);
    if (user) {
      int userId = await _services.getUserId();
      var result = await _cartService.checkoutProduct(userId, m.total!);
      if (result) {
        return true;
      } else {
        return false;
      }
    } else {
      var result = await _cartService.checkoutProduct(ip, m.total!);
      if (result) {
        print(result);
        navigateToSuccess();
      } else {
        print(result);
      }
    }
    isBusy(false);
  }
}
