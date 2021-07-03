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
  // getCount() async {
  //   var _userIp = await Ipify.ipv4();
  //   var _user = await _auth.currrentUser();
  //   if (_user) {
  //     var userId = await _auth.getUserId();
  //     var count = await _cart.getCartCount(userId);
  //     cartCount = count;
  //     notifyListeners();
  //   } else {
  //     var count = await _cart.getCartCount(_userIp);
  //     cartCount = count;
  //     notifyListeners();
  //   }
  // }

  getCount() async {
    var wishcount = await _wish.WishProductCount(6);
    print(wishcount);
    var cartcount = await _cart.cartProductCount(6);
    wishlistCount = wishcount;
    cartCount = cartcount;
    notifyListeners();
  }

  onDropDownChange(var newValue, var dropDownVal) {
    dropDownVal = newValue!;
    notifyListeners();
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

  navigateToSignInLogInPage(bool isSignIn) {
    if (isSignIn) {
      _navigation.navigateTo(SignUp);
    } else {
      _navigation.navigateTo(SignIn);
    }
  }
}
