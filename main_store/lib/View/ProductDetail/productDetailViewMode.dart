import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';
import 'package:main_store/Services/Api/Products/filterProducts.dart';

class ProductDetailViewModel extends ChangeNotifier {
  FilterProducts _filterProducts = locator<FilterProducts>();
  CartService _cart = locator<CartService>();
  int quantity = 1;
  bool isLoading = false;
  List<ProductsModel> relatedlist = [];

  addOrMiuns(bool adding) {
    if (adding) {
      quantity++;
      notifyListeners();
    } else {
      if (quantity <= 1) {
        quantity = 1;
      } else
        quantity--;
      notifyListeners();
    }
  }

  createBreadCrums() {}

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  Future addtoCart(int productId, int storeId) async {
    isBusy(true);
    int userId = 6;
    var result = await _cart.addToCart(productId, storeId, userId, quantity);
    if (result is bool) {
      if (result)
        return true;
      else
        return false;
    }
    isBusy(false);
  }

  // Future addtoCart(String? productId, String? storeName) async {
  //   isBusy(true);
  //   var _userIp = await Ipify.ipv4();
  //   var _user = await _auth.currrentUser();
  //   print(quantity);
  //   if (_user) {
  //     String userId = await _auth.getUserId();
  //     var result = await _cart.addtoCartCollection(
  //         userId, productId!, storeName, quantity);
  //     print(result);
  //   } else {
  //     await _cart.addtoCartCollection(_userIp, productId!, storeName, quantity);
  //   }
  //   isBusy(false);
  // }

  fetchRelatedProduct(List<String> category) async {
    print(category);
    var result = await _filterProducts.byCategory(category);
    if (result is List<ProductsModel>) {
      relatedlist = result;
      notifyListeners();
    } else {
      print(result);
    }
  }
}
