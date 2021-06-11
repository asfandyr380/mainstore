import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/Banners.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_products.dart';

class HomeViewModel extends ChangeNotifier {
  List<Banners> bannerlist = [];
  Products _products = locator<Products>();
  List<ProductsModel> onSaleProducts = [];
  List<ProductsModel> topSellingProducts = [];
  List<ProductsModel> nearbyProducts = [];

  getBanner(List<Banners> banners) {
    bannerlist = banners;
    notifyListeners();
  }

  fetchNearbyProducts() async {
    var result = await _products.nearbyProducts();
    if (result is List<ProductsModel>) {
      nearbyProducts = result;
      notifyListeners();
    } else {
      print(result);
    }
  }

  fetchTopSellingProducts() async {
    var result = await _products.topSellingProducts();
    if (result is List<ProductsModel>) {
      topSellingProducts = result;
      notifyListeners();
    } else {
      print(result);
    }
  }

  fetchOnSaleProducts() async {
    var result = await _products.onSaleProducts();
    if (result is List<ProductsModel>) {
      onSaleProducts = result;
      notifyListeners();
    } else {
      print(result);
    }
  }
}
