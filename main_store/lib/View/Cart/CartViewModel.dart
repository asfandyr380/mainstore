import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/Models/SummeryModel.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

class CartViewModel extends ChangeNotifier {
  List<CartModel> cartlist = [];
  CartService _cartService = locator<CartService>();
  StorageServices _services = locator<StorageServices>();
  Navigation _navigaton = locator<Navigation>();
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

  navigateToCheckOut(double total, double subTotal, double shipping) {
    var m = SummeryModel.mapData(subTotal, shipping, total, []);
    _navigaton.navigateTo(Checkout, arguments: m);
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
      if (product.products!.attributePrice == 0) {
        subTotal += product.products!.productPrice! * product.quantity!;
      } else {
        subTotal += product.products!.attributePrice! * product.quantity!;
      }
      notifyListeners();
    } else {
      if (product.products!.attributePrice == 0) {
        subTotal -= product.products!.productPrice! * product.quantity!;
      } else {
        subTotal -= product.products!.attributePrice! * product.quantity!;
      }
      notifyListeners();
    }
    total = shipping + subTotal;
  }

  getcart() async {
    isBusy(true);
    var user = await _services.getUser();
    var _userIp = await Ipify.ipv4();
    String i = _userIp.replaceAll('.', '');
    String newI = i.substring(i.length - 5);
    int ip = int.parse(newI);
    if (user) {
      int id = await _services.getUserId();
      print('userID $id');
      var result = await _cartService.getCartProducts(id);
      if (result is List<CartModel>) {
        cartlist = result;
        notifyListeners();
        print(cartlist);
      } else {
        print(result);
      }
    } else {
      var result = await _cartService.getCartProducts(ip);
      if (result is List<CartModel>) {
        cartlist = result;
        notifyListeners();
        print(cartlist);
      } else {
        print(result);
      }
    }

    isBusy(false);
    getCount();
  }

  Future removeProductFromCart(int id) async {
    var result = await _cartService.deleteFromCart(id);
    print(result);
    if (result is bool) {
      if (result) {
        getcart();
        return true;
      } else {
        return false;
      }
    }
    subTotal = 0;
  }
}

class CartMobileViewModel extends ChangeNotifier {}
