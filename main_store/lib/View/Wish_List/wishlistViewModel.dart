import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Wishlist/wishlist_Services.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';

class WishlistViewModel extends ChangeNotifier {
  WishServices _wish = locator<WishServices>();
  List<ProductsModel> products = [];

  fetchWishlist() async {
    var result = await _wish.getWishlist(6);
    print(result);
    if (result is List<ProductsModel>) {
      products = result;
      notifyListeners();
    } else {}
  }
}
