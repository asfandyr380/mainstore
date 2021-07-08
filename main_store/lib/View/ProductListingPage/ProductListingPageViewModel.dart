import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/categoryModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Products/filterProducts.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_categorys.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductListingPageViewModel extends ChangeNotifier {
  FilterProducts _filterProducts = locator<FilterProducts>();
  SfRangeValues range = SfRangeValues(0, 100);
  List<ProductsModel> productList = [];
  List<ProductsModel> filterlist = [];
  List<String> category = [];
  bool selectState = false;
  bool isLoading = false;
  bool byRange = false;

  GetCategorys _cate = locator<GetCategorys>();
  List<Future<CategoryModel>> _categorylist = [];
  List<CategoryModel> catelist = [];

  fetchCategorys() async {
    var result = await _cate.getCategory();
    if (result is List<Future<CategoryModel>>) {
      _categorylist = result;
      notifyListeners();
      for (var catemodel in _categorylist) {
        catemodel.then((value) {
          catelist.add(value);
        });
      }
    }
  }

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

  byCategory(List cate) async {
    category = cate as List<String>;
    notifyListeners();
    print(category);
    fetchProductByFilter(category);
  }

  fetchProductByFilter(List<String>? cate) async {
    isBusy(true);
    var result = await _filterProducts.byCategory(cate!);
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
