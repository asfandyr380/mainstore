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
      productList.sort((a, b) => a.productPrice!.compareTo(b.productPrice!));
    else
      fetchProductByFilter(null, false);
  }

  changePriceRange() {
    productList.sort((a, b) => a.productPrice!.compareTo(b.productPrice!));
  }

  fetchProductByFilter(String? cate, bool? descending) async {
    isBusy(true);
    var result = await _filterProducts.byCategory([]);
    if (result is List<ProductsModel>) {
      productList = result;
      notifyListeners();
    } else {
      print(result);
      isBusy(false);
    }
  }
}
