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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  validateForum(String? forumValue, String fieldName) {
    // ignore: unnecessary_null_comparison
    if (forumValue == null || forumValue.isEmpty) {
      return 'Enter $fieldName';
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

  validateInputs() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return 1;
    } else {
      autovalidateMode = AutovalidateMode.onUserInteraction;
      notifyListeners();
    }
  }

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
    // updateCart(ids);
    isBusy(false);
  }
}
