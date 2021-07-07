import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/ReviewModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';
import 'package:main_store/Services/Api/Products/filterProducts.dart';
import 'package:main_store/Services/Api/Reviews/reviewsServices.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

class ProductDetailViewModel extends ChangeNotifier {
  FilterProducts _filterProducts = locator<FilterProducts>();
  StorageServices _services = locator<StorageServices>();
  Navigation _navigation = locator<Navigation>();
  ReviewServices _reviewServices = locator<ReviewServices>();
  CartService _cart = locator<CartService>();
  int quantity = 1;
  bool isLoading = false;
  bool onReview = false;
  List<ProductsModel> relatedlist = [];
  List<ReviewModel> reviewlist = [];
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

  changeView() async {
    if (onReview) {
      onReview = false;
      notifyListeners();
    } else {
      onReview = true;
      notifyListeners();
    }
  }

  getReviews() async {
    var result = await _reviewServices.getReviews();
    if (result is List<ReviewModel>) {
      reviewlist = result;
      notifyListeners();
    }
  }

  navigateToProductlisting(String cate) {
    _navigation.navigateTo(ProductListing, arguments: [cate]);
  }

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  Future addtoCart(int productId, int storeId, double attributePrice) async {
    isBusy(true);
    var user = await _services.getUser();
    var _userIp = await Ipify.ipv4();
    String i = _userIp.replaceAll('.', '');
    String newI = i.substring(i.length - 5);
    int ip = int.parse(newI);
    print(ip);
    if (user) {
      int userId = await _services.getUserId();
      var result = await _cart.addToCart(
          productId, storeId, userId, quantity, attributePrice);
      if (result == 1)
        return true;
      else
        return false;
    } else {
      var result = await _cart.addToCart(
          productId, storeId, ip, quantity, attributePrice);
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
