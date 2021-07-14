import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/BrandsModel.dart';
import 'package:main_store/Services/Api/Banners/banner_Services.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_banners.dart';

class BrandCardViewModel extends ChangeNotifier {
  BannerServices _banner = locator<BannerServices>();
  List<BrandsModel> brandslits = [];
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

  fetchBrands() async {
    var result = await _banner.getBrands();
    if (result is List<BrandsModel>) {
      brandslits = result;
      notifyListeners();
    } else {
      print(result);
    }
  }
}
