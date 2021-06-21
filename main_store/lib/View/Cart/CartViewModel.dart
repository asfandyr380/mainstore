import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Fireabase/Firestore/cart_services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:dart_ipify/dart_ipify.dart';

class CartViewModel extends ChangeNotifier {
  List<CartModel> cartlist = [];
  CartServices _cart = locator<CartServices>();
  Navigation _navigation = locator<Navigation>();
  Auth _auth = locator<Auth>();

  getCart() async {
    var _user = await _auth.currrentUser();
    var _userIp = await Ipify.ipv4();
    if (_user) {
      String userId = await _auth.getUserId();
      var result = await _cart.getCartProducts(userId);
      if (result is List<CartModel>) {
        cartlist = result;
        notifyListeners();
      } else {
        print(result);
      }
    } else {
      var result = await _cart.getCartProducts(_userIp);
      if (result is List<CartModel>) {
        cartlist = result;
        notifyListeners();
      } else {
        print(result);
      }
    }
  }

  Future removefromCart(String storeName, DocumentReference productRef) async {
    var user = await _auth.currrentUser();
    var _userIp = await Ipify.ipv4();
    if (user) {
      String userId = await _auth.getUserId();
      await _cart.removefromcart(userId, storeName, productRef).then((value) {
        getCart();
      });
    } else {
      // TODO Remove from ip base user
      await _cart.removefromcart(_userIp, storeName, productRef).then((value) {
        getCart();
      });
    }
  }
}

class CartMobileViewModel extends ChangeNotifier {}
