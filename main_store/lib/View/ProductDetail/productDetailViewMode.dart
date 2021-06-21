import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Fireabase/Firestore/cart_services.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_products.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class ProductDetailViewModel extends ChangeNotifier {
  Products _products = locator<Products>();
  CartServices _cart = locator<CartServices>();
  Navigation _navigation = locator<Navigation>();
  int quantity = 0;
  bool isLoading = false;

  addOrMiuns(bool adding) {
    if (adding) {
      quantity++;
      notifyListeners();
    } else {
      if (quantity <= 0) {
        quantity = 0;
      } else
        quantity--;
      notifyListeners();
    }
  }

  createBreadCrums() {}

  Auth _auth = locator<Auth>();
  List<ProductsModel> relatedlist = [];

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  Future addtoCart(
      DocumentReference? productId, String? storeName, int quantity) async {
    isBusy(true);
    var _userIp = await Ipify.ipv4();
    var _user = await _auth.currrentUser();
    if (_user) {
      String userId = await _auth.getUserId();
      await _cart.addtoCartCollection(userId, productId!, storeName, quantity);
    } else {
      await _cart.addtoCartCollection(_userIp, productId!, storeName, quantity);
    }
    isBusy(false);
  }

  fetchRelatedProduct(List<String> category) async {
    var result = await _products.relatedProducts(category);
    if (result is List<ProductsModel>) {
      relatedlist = result;
      notifyListeners();
    } else {
      print(result);
    }
  }
}
