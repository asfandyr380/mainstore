import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/SummeryModel.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';
import 'package:main_store/View/SuccessPage/successPage.dart';

class CheckOutViewModel extends ChangeNotifier {
  CartService _cartService = locator<CartService>();
  StorageServices _services = locator<StorageServices>();
  Navigation _navigation = locator<Navigation>();
  DialogService _alertDialog = locator<DialogService>();

  String phone = '';
  String firstName = '';
  String lastName = '';
  String address = '';
  String apartment = '';
  String city = '';
  String country = '';
  String postalCode = '';

  bool isLoading = false;

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  navigateToSuccess() {
    _navigation.pushReplaceRoute(Success());
  }

  navigateToLogin() async {
    _navigation.navigateTo(SignIn);
  }

  updateCart(List<int> ids) async {
    print(ids);
    for (var id in ids) {
      var result = await _cartService.updateCartStatus(id);
      if (result) {
        print(result);
      }
    }
  }

  checkout(SummeryModel m, List<int> ids) async {
    isBusy(true);
    if (phone.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        address.isEmpty ||
        city.isEmpty ||
        country.isEmpty ||
        postalCode.isEmpty) {
      _alertDialog.showDialog(
          title: 'Validation Error',
          description: 'Please fill in the Shipping Information',
          buttonTitle: "Close");
    } else {
      var user = await _services.getUser();
      var _userIp = await Ipify.ipv4();
      String i = _userIp.replaceAll('.', '');
      String newI = i.substring(i.length - 5);
      int ip = int.parse(newI);
      if (user) {
        int userId = await _services.getUserId();
        var result = await _cartService.checkoutProduct(userId, m.total!);
        if (result) {
          updateCart(ids);
          navigateToSuccess();
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
    }
    // updateCart(ids);
    isBusy(false);
  }
}
