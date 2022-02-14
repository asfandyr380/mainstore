import 'dart:async';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';
import 'package:main_store/Services/Api/Wishlist/wishlist_Services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

class HeaderViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();
  CartService _cart = locator<CartService>();
  WishServices _wish = locator<WishServices>();

  bool userLogedIn = false;
  int cartCount = 0;
  int wishlistCount = 0;
  StorageServices _services = locator<StorageServices>();
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  reload() {
    Timer.periodic(Duration(seconds: 5), (_) => getCount());
  }

  getCount() async {
    var user = await _services.getUser();
    var _userIp = await Ipify.ipv4();
    String i = _userIp.replaceAll('.', '');
    String newI = i.substring(i.length - 5);
    int ip = int.parse(newI);

    if (user) {
      int userId = await _services.getUserId();
      var wishcount = await _wish.WishProductCount(userId);
      var cartcount = await _cart.cartProductCount(userId);
      wishlistCount = wishcount;
      cartCount = cartcount;
      notifyListeners();
    } else {
      var wishcount = await _wish.WishProductCount(ip);
      var cartcount = await _cart.cartProductCount(ip);
      wishlistCount = wishcount;
      cartCount = cartcount;
      notifyListeners();
    }
  }

  onDropDownChange(var newValue, var dropDownVal) {
    dropDownVal = newValue!;
    notifyListeners();
  }

  selectOption(String val) {
    if (val == "1") {
      navigateToDashboard();
    } else if (val == "2") {
      signoutUser();
    }
  }

  navigateToDashboard() {
    _navigation.navigateTo(Dashboard);
  }

  // Signout Current User
  signoutUser() async {
    await _services.deleteUser().then(
          (value) => getUser(),
        );
  }

  Future<bool> getUser() async {
    bool result = await _services.getUser();
    userLogedIn = result;
    notifyListeners();
    return userLogedIn;
  }

  navigateToAbout() {
    _navigation.navigateTo(AboutUs);
  }

  navigateToHome() {
    _navigation.navigateTo(HomeView);
  }

  navigateToContact() {
    _navigation.navigateTo(ContactUs);
  }

  navigateToCart() {
    _navigation.navigateTo(Cart);
  }

  navigateToWishlist() {
    _navigation.navigateTo(Wishlist);
  }

  navigateToLogInPage() {
    _navigation.navigateTo(SignIn);
  }

  init() {
    getUser();
    getCount();
  }

  disposeStuff() {}
}
