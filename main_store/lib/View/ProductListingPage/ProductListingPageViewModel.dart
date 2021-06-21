import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_products.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductListingPageViewModel extends ChangeNotifier {
  Products _products = locator<Products>();
  SfRangeValues range = SfRangeValues(0, 100);
  List<ProductsModel> productList = [];
  bool isLoading = false;

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  onChange(SfRangeValues newVal) {
    range = newVal;
    notifyListeners();
    fetchProductByFilter(null, false);
  }

  orderBy(val) {
    if (val == "High to Low")
      fetchProductByFilter(null, true);
    else
      fetchProductByFilter(null, false);
  }

  fetchProductByFilter(String? cate, bool? descending) async {
    isBusy(true);
    var result = await _products.productsbyFilter(
      range.start,
      range.end,
      cate,
      descending,
    );
    if (result is List<ProductsModel>) {
      productList = result;
      notifyListeners();
      isBusy(false);
    } else {
      print(result);
      isBusy(false);
    }
  }
}
