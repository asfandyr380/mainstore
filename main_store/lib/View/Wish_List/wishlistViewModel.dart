import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';
import 'package:main_store/Services/Api/Wishlist/wishlist_Services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

class WishlistViewModel extends ChangeNotifier {
  WishServices _wish = locator<WishServices>();
  StorageServices _services = locator<StorageServices>();
  bool isLoading = false;
  CartService _cart = locator<CartService>();

  List<ProductsModel> products = [];

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  Future addtoCart(int productId, int storeId, String attributePrice) async {
    isBusy(true);
    var user = await _services.getUser();
    var _userIp = await Ipify.ipv4();
    String i = _userIp.replaceAll('.', '');
    String newI = i.substring(i.length - 5);
    int ip = int.parse(newI);
    print(ip);
    if (user) {
      int userId = await _services.getUserId();
      var result =
          await _cart.addToCart(productId, storeId, userId, 1, attributePrice);
      if (result == 1)
        return true;
      else
        return false;
    } else {
      var result =
          await _cart.addToCart(productId, storeId, ip, 1, attributePrice);
      if (result is bool) {
        if (result)
          return true;
        else
          return false;
      }
    }
    print(isLoading);
    isBusy(false);
  }

  fetchWishlist() async {
    var user = await _services.getUser();
    var _userIp = await Ipify.ipv4();
    String i = _userIp.replaceAll('.', '');
    String newI = i.substring(i.length - 5);
    int ip = int.parse(newI);

    if (user) {
      int userId = await _services.getUserId();
      var result = await _wish.getWishlist(userId);
      if (result is List<ProductsModel>) {
        products = result;
        notifyListeners();
      } else {
        print(result);
      }
    } else {
      var result = await _wish.getWishlist(ip);
      if (result is List<ProductsModel>) {
        products = result;
        notifyListeners();
      } else {
        print(result);
      }
    }
  }
}
