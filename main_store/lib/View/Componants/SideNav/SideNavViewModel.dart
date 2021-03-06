import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/categoryModel.dart';
import 'package:main_store/Services/Api/Category/category_services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class SideNavViewModel extends ChangeNotifier {
  CategoryServices _cate = locator<CategoryServices>();
  List<CategoryModel> catelist = [];

  Navigation _navigation = locator<Navigation>();
  navigateToProductlisting(String cate) async {
    _navigation.navigateTo(ProductListing, arguments: [cate]);
  }

  fetchCategorys() async {
    Future.delayed(Duration(seconds: 7), () async {
      var result = await _cate.getCategorys();
      if (result is List<CategoryModel>) {
        catelist = result;
        notifyListeners();
      }
    });
  }
}
