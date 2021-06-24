import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Fireabase/Firestore/cart_services.dart';
import 'package:dart_ipify/dart_ipify.dart';

class CartViewModel extends ChangeNotifier {
  List<CartModel> cartlist = [];
  CartServices _cart = locator<CartServices>();
  Auth _auth = locator<Auth>();
  double subTotal = 0;
  double shipping = 0;
  double total = 0;
  int itemCount = 0;
  int quantity = 0;
  bool selected = false;
  bool nestedSelect = false;
  bool isLoading = false;

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  onSelect(bool val, CartProducts cart) {
    cart.isSelected = val;
    notifyListeners();
    getSummery(product: cart);
  }

  nestedSelectall(bool checkState, CartModel cartProducts) {
    cartProducts.isSelected = checkState;
    for (var cart in cartProducts.product) {
      cart.isSelected = checkState;
      notifyListeners();
      getSummery(cart: cartProducts, product: cart);
    }
  }

  selectall(bool checkstate) {
    for (var cart in cartlist) {
      selected = checkstate;
      cart.isSelected = checkstate;
      nestedSelectall(checkstate, cart);
      notifyListeners();
      // getSummery(cart, cart.product);
    }
  }

  getCount() {
    itemCount = 0;
    for (var cart in cartlist) {
      itemCount = itemCount + cart.product.length;
    }
  }

  getSummery({CartModel? cart, required CartProducts product}) {
    if (product.isSelected!) {
      subTotal += product.products!.productPrice!;
      notifyListeners();
    } else {
      subTotal -= product.products!.productPrice!;
      notifyListeners();
    }

    total = shipping + subTotal;
  }

  getCart() async {
    isBusy(true);
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
    isBusy(false);
    getCount();
  }

  Future removefromCart(String storeName, String productId) async {
    var user = await _auth.currrentUser();
    print(productId);
    var _userIp = await Ipify.ipv4();
    if (user) {
      String userId = await _auth.getUserId();
      await _cart.removefromcart(userId, storeName, productId).then((value) {
        getCart();
      });
    } else {
      await _cart.removefromcart(_userIp, storeName, productId).then((value) {
        getCart();
      });
    }
    subTotal = 0;
  }
}

class CartMobileViewModel extends ChangeNotifier {}
