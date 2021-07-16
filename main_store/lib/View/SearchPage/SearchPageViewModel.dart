import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Products/searchProducts.dart';

class SearchPageViewModel extends ChangeNotifier {
  SearchProductServices _services = locator<SearchProductServices>();
  List<ProductsModel> product = [];

  search() async {
    var result = await _services.seaerhForProduct('');
    if (result is List<ProductsModel>) {
      product = result;
      notifyListeners();
    }
  }
}
