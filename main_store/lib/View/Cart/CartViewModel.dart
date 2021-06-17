import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Fireabase/Firestore/cart_services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class CartViewModel extends ChangeNotifier {
  List<CartModel> cartlist = [];
  CartServices _cart = locator<CartServices>();
  Navigation _navigation = locator<Navigation>();
  Auth _auth = locator<Auth>();

  getCart() async {
    var user = await _auth.currrentUser();
    if (user) {
      String userId = await _auth.getUserId();
      var result = await _cart.getCartProducts(userId);
      if (result is List<CartModel>) {
        cartlist = result;
        notifyListeners();
      } else {
        print(result);
      }
    } else {
      _navigation.navigateTo(SignIn);
    }
  }
}
