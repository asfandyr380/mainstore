import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/Banners.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_banners.dart';

class BannersViewModel extends ChangeNotifier {
  CategoryBanners _banner = locator<CategoryBanners>();
  List<Banners> bannerlist = [];

  Future fetchBanners() async {
    var result = await _banner.getBanners();
    if (result is List<Banners>) {
      bannerlist = result;
      notifyListeners();
    } else {
      // TODO: Show Error
      print(result);
    }
  }
}
