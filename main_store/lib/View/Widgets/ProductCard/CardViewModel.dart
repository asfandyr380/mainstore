import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Api/Wishlist/wishlist_Services.dart';

class CardViewModel extends ChangeNotifier {
  WishServices _wish = locator<WishServices>();
  bool onWishlist = false;

  Future removeFromlist(int id) async {
    var result = await _wish.removeFromWish(id);
    if (result is bool) {
      if (result) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future addtoWishlist(int productId) async {
    var result = await _wish.addToWishlist(6, productId);
    if (result is bool) {
      if (result)
        return true;
      else
        return false;
    }
  }
}
