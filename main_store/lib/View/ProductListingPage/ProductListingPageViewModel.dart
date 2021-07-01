import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Products/filterProducts.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_products.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductListingPageViewModel extends ChangeNotifier {
  Products _products = locator<Products>();
  FilterProducts _filterProducts = locator<FilterProducts>();
  SfRangeValues range = SfRangeValues(0, 100);
  List<ProductsModel> productList = [];
  List<ProductsModel> filterlist = [];
  List<String> category = [];

  bool isLoading = false;
  bool byRange = false;

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  onChange(SfRangeValues newVal) {
    range = newVal;
    byRange = true;
    notifyListeners();
    byPrice();
  }

  byPrice() async {
    var list = productList;
    filterlist = list
        .where((p) =>
            p.productPrice! >= range.start && p.productPrice! <= range.end)
        .toList();
    notifyListeners();
  }

  orderBy(val) {
    if (val == "High to Low") {
      productList.sort((a, b) => b.productPrice!.compareTo(a.productPrice!));
      filterlist.sort((a, b) => b.productPrice!.compareTo(a.productPrice!));
      notifyListeners();
    } else {
      productList.sort((a, b) => a.productPrice!.compareTo(b.productPrice!));
      filterlist.sort((a, b) => a.productPrice!.compareTo(b.productPrice!));
      notifyListeners();
    }
  }

  byCategory(String cate, bool state) async {
    if (state) {
      category.add(cate);
    } else {
      category.remove(cate);
    }
    fetchProductByFilter(category);
  }

  fetchProductByFilter(List<String>? cate) async {
    isBusy(true);
    var result = await _filterProducts.byCategory([]);
    if (result is List<ProductsModel>) {
      productList = result;
      byRange = false;
      notifyListeners();
    } else {
      print(result);
    }
    isBusy(false);
  }
}
