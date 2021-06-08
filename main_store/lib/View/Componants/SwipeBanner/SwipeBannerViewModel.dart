import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/swipeBanner.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_banners.dart';

class SwipeBannerViewModel extends ChangeNotifier {
  int currentIndex = 0;
  CategoryBanners _banner = locator<CategoryBanners>();
  List<Swipebanner> list = [];
  onPageChange(int i) {
    currentIndex = i;
    notifyListeners();
  }

  fetchBanner() async {
    var result = await _banner.getSwipeBanners();
    if (result is List<Swipebanner>) {
      list = result;
      notifyListeners();
    } else {
      print(result);
    }
  }
}
