import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/Models/SummeryModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Js/webPayment.dart';
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
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  AutovalidateMode autovalidateMode2 = AutovalidateMode.disabled;

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

  int validateInputs2() {
    final form = formKey2.currentState;
    if (form!.validate()) {
      return 1;
    } else {
      autovalidateMode2 = AutovalidateMode.onUserInteraction;

      notifyListeners();

      return 0;
    }
  }

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  navigateToSuccess() {
    _navigation.pushReplaceRoute(Success(''));
  }

  navigateToLogin() async {
    _navigation.navigateTo(SignIn);
  }

  Future<String?> createCheckoutSession(
      int checkoutId, List<CartProducts>? products, List<int> ids) async {
    List<Map> items = [];
    if (products != null) {
      products.forEach((product) {
        var map = {
          'name': product.products!.name,
          "price": product.products!.attributePrice == 0
              ? product.products!.productPrice
              : product.products!.attributePrice!.toDouble(),
          'quantity': product.quantity,
        };
        items.add(map);
      });
    }
    var res = await _cartService.createCheckoutSession(
      items,
      checkoutId.toString(),
      "$firstName$lastName",
      postalCode,
      address,
      ids,
    );
    if (res is String) {
      return res;
    } else
      return null;
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
      var result = await _cartService.checkoutProduct(
        userId,
        m.total!,
        m.subtotal!,
        address,
        postalCode,
        "$firstName $lastName",
      );
      if (result is int) {
        createCheckoutSession(result, m.products, ids).then((sessionId) {
          if (sessionId != null) redirectToCheckout(sessionId);
        });
        return true;
      } else {
        return false;
      }
    } else {
      var result = await _cartService.checkoutProduct(
        ip,
        m.total!,
        m.subtotal!,
        address,
        postalCode,
        "$firstName $lastName",
      );
      if (result is int) {
        createCheckoutSession(result, m.products, ids).then((sessionId) {
          if (sessionId != null) redirectToCheckout(sessionId);
        });
      } else {
        print(result);
      }
    }
    isBusy(false);
  }
}
