import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/Banners.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_products.dart';

class HomeViewModel extends ChangeNotifier {
  List<Banners> bannerlist = [];
  List<String> _docIds = [];
  Products _products = locator<Products>();
  List<ProductsModel> onSaleProducts = [];
  List<ProductsModel> topSellingProducts = [];
  List<ProductsModel> nearbyProducts = [];

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
    var result = await _products.nearbyProducts(doclist);
    if (result is List<ProductsModel>) {
      nearbyProducts = result;
      notifyListeners();
    } else {
      print(result);
    }
  }

  fetchTopSellingProducts(List<String> doclist) async {
    var result = await _products.topSellingProducts(doclist);
    if (result is List<ProductsModel>) {
      topSellingProducts = result;
      notifyListeners();
    } else {
      print(result);
    }
  }

  fetchOnSaleProducts(List<String> doclist) async {
    var result = await _products.onSaleProducts(doclist);
    if (result is List<ProductsModel>) {
      onSaleProducts = result;
      notifyListeners();
    } else {
      print(result);
    }
  }
}
