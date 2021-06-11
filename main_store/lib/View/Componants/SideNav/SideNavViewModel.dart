import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/categoryModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_categorys.dart';

class SideNavViewModel extends ChangeNotifier {
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
}
