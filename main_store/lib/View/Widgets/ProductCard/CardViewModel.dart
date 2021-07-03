import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Api/Wishlist/wishlist_Services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

class CardViewModel extends ChangeNotifier {
  WishServices _wish = locator<WishServices>();
  StorageServices _services = locator<StorageServices>();

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
    var user = await _services.getUser();
    var _userIp = await Ipify.ipv4();
    String i = _userIp.replaceAll('.', '');
    String newI = i.substring(i.length - 5);
    int ip = int.parse(newI);
    if (user) {
      var userId = await _services.getUserId();
      var result = await _wish.addToWishlist(userId, productId);
      if (result is bool) {
        if (result)
          return true;
        else
          return false;
      }
    } else {
      var result = await _wish.addToWishlist(ip, productId);
      if (result is bool) {
        if (result)
          return true;
        else
          return false;
      }
    }
  }
}
