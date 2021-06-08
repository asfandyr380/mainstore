import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/BrandsModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_banners.dart';

class BrandCardViewModel extends ChangeNotifier {
  CategoryBanners _banner = locator<CategoryBanners>();
  List<BrandsModel> brandslits = [];

  fetchBrands() async {
    var result = await _banner.getBrandsInfo();
    if (result is List<BrandsModel>) {
      brandslits = result;
      notifyListeners();
    } else {
      print(result);
    }
  }
}
