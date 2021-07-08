import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/categoryModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_categorys.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class SideNavViewModel extends ChangeNotifier {
  GetCategorys _cate = locator<GetCategorys>();
  List<Future<CategoryModel>> _categorylist = [];
  List<CategoryModel> catelist = [];

  Navigation _navigation = locator<Navigation>();
  navigateToProductlisting(String cate) async {
    print(cate);
    _navigation.navigateTo(ProductListing, arguments: [cate]);
  }

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
}
