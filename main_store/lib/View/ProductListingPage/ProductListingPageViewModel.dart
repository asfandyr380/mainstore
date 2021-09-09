import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/categoryModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Category/category_services.dart';
import 'package:main_store/Services/Api/Products/filterProducts.dart';
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
  int totalCount = 0;
  int totalPage = 0;
  int currentPage = 0;
  int currentProductOffset = 0;
  CategoryServices _cate = locator<CategoryServices>();
  List<CategoryModel> catelist = [];

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  changePage(int page, count) {
    currentPage = count;
    currentProductOffset = page;
    notifyListeners();
    print(page);
    fetchProductByFilter([], []);
  }

  fetchCategorys() async {
    var result = await _cate.getCategorys();
    if (result is List<CategoryModel>) {
      catelist = result;
      notifyListeners();
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

  byCategory(Map cate) async {
    print(cate);
    List superCate = cate['Super'];
    List subCate = cate['Sub'];
    fetchProductByFilter(superCate, subCate);
  }

  filterByStore(String name) async {
    isBusy(true);
    var result = await _filterProducts.byStore(name, currentPage);
    if (result is List<ProductsModel>) {
      productList = result;
      byRange = false;
      totalCount = _filterProducts.totalProducts;
      notifyListeners();
    } else {
      print(result);
    }
    isBusy(false);
  }

  fetchProductByFilter(List? cate, List? sub) async {
    isBusy(true);
    var result =
        await _filterProducts.byCategory(cate!, sub!, currentProductOffset);
    if (result is List<ProductsModel>) {
      productList = result;
      byRange = false;
      totalCount = _filterProducts.totalProducts;
      totalPage = _filterProducts.totalPage;
      currentProductOffset = _filterProducts.currentProduct;
      notifyListeners();
    } else {
      print(result);
    }
    isBusy(false);
  }
}
