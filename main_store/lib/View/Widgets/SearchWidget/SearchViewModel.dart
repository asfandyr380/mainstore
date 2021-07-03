import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Products/searchProducts.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class SearchViewModel extends ChangeNotifier {
  SearchProductServices _services = locator<SearchProductServices>();
  Navigation _navigation = locator<Navigation>();

  Future<List> search(String key) async {
    List<ProductsModel> result = await _services.seaerhForProduct(key);
    return result;
  }

  navigatetodetails(ProductsModel category) {
    _navigation.navigateTo(ProductDetailsPage, arguments: category);
  }
}
