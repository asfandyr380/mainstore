import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/Models/SummeryModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

class CartViewModel extends ChangeNotifier {
  List<CartModel> cartlist = [];
  List<int> ids = [];
  List<CartProducts> selectedProducts = [];
  CartService _cartService = locator<CartService>();
  StorageServices _services = locator<StorageServices>();
  Navigation _navigaton = locator<Navigation>();
  double subTotal = 0;
  double shipping = 0;
  double total = 0;
  int itemCount = 0;
  bool selected = false;
  bool isLoading = false;

  addorPlus(bool state, CartProducts cart) async {
    if (state) {
      cart.quantity = cart.quantity! + 1;
      notifyListeners();
    } else {
      if (cart.quantity != 1) {
        cart.quantity = cart.quantity! - 1;
        notifyListeners();
      }
    }
  }

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  navigateToCheckOut(double total, double subTotal, double shipping) {
    var m = SummeryModel.mapData(subTotal, shipping, total, [], []);
    _navigaton.navigateTo(Checkout, arguments: m);
  }

  onSelect(bool val, CartProducts cart) {
    cart.isSelected = val;
    notifyListeners();
    getSummery(product: cart);
    getIds();
  }

  nestedSelectall(bool checkState, CartModel cart) {
    cart.isSelected = checkState;
    notifyListeners();
    for (var cart in cart.product) {
      onSelect(checkState, cart);
    }
  }

  selectAll(bool state) async {
    selected = state;
    for (var cart in cartlist) {
      cart.isSelected = state;
      notifyListeners();
      nestedSelectall(state, cart);
    }
  }

  getIds() {
    for (var cart in cartlist) {
      for (var product in cart.product) {
        if (product.isSelected!) {
          if (ids.contains(product.cartId)) {
            ids.remove(product.cartId);
            selectedProducts.remove(product);
          } else {
            ids.add(product.cartId);
            selectedProducts.add(product);
          }
        }
      }
    }
  }

  getCount() {
    itemCount = 0;
    for (var cart in cartlist) {
      itemCount = itemCount + cart.product.length;
    }
  }

  getSummery({required CartProducts product}) {
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
      var result = await _cartService.getCartProducts(id);
      if (result is List<CartModel>) {
        cartlist = result;
        notifyListeners();
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
