import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Fireabase/Firestore/Wishlist_services.dart';

class WishlistViewModel extends ChangeNotifier {
  WishListServices _wish = locator<WishListServices>();
  Auth _auth = locator<Auth>();
  List<ProductsModel> products = [];

  fetchWishlist() async {
    var user = await _auth.currrentUser();
    if (user) {
      String userId = await _auth.getUserId();
      var result = await _wish.getWishlist(userId);
      print(result);

      if (result is List<ProductsModel>) {
        products = result;
        notifyListeners();
      }
    } else {}
  }
}
