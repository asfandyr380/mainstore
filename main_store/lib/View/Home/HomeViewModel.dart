import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/Banners.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_products.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class HomeViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();
  List<Banners> bannerlist = [];
  List<String> _docIds = [];
  int present = 0;
  int perPage = 11;
  var items = <ProductsModel>[];
  Products _products = locator<Products>();
  List<ProductsModel> onSaleProducts = [];
  List<ProductsModel> topSellingProducts = [];
  List<ProductsModel> nearbyProducts = [];
  bool isLoading = false;

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  loadMore() async {
    if ((present + perPage) > nearbyProducts.length) {
      items.addAll(nearbyProducts.getRange(present, nearbyProducts.length));
      notifyListeners();
    } else {
      items.addAll(nearbyProducts.getRange(present, present + perPage));
      notifyListeners();
    }
    present = present + perPage;
    notifyListeners();
  }

  navigatetodetails(ProductsModel category) {
    _navigation.navigateTo(ProductDetailsPage, arguments: category);
  }

  Future<List<String>> getAvailableProduct() async {
    var result = await _products.getStoreProducts();
    if (result is List<String>) {
      _docIds = result;
      notifyListeners();
    }
    return _docIds;
  }

  getBanner(List<Banners> banners) {
    bannerlist = banners;
    notifyListeners();
  }

  fetchNearbyProducts(List<String> doclist) async {
    isBusy(true);
    var result = await _products.nearbyProducts(doclist);
    if (result is List<ProductsModel>) {
      nearbyProducts = result;
      notifyListeners();
      // load more on button press
      items.addAll(nearbyProducts.getRange(present, present + perPage));
      present = present + perPage;
      notifyListeners();
    } else {
      print(result);
    }
    isBusy(false);
  }

  fetchTopSellingProducts(List<String> doclist) async {
    isBusy(true);
    var result = await _products.topSellingProducts(doclist);
    if (result is List<ProductsModel>) {
      topSellingProducts = result;
      notifyListeners();
    } else {
      print(result);
    }
    isBusy(false);
  }

  fetchOnSaleProducts(List<String> doclist) async {
    isBusy(true);
    var result = await _products.onSaleProducts(doclist);
    if (result is List<ProductsModel>) {
      onSaleProducts = result;
      notifyListeners();
    } else {
      print(result);
    }
    isBusy(false);
  }
}
