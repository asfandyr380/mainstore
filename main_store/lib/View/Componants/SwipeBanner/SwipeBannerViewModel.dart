import 'dart:async';

import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/swipeBanner.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_banners.dart';

class SwipeBannerViewModel extends ChangeNotifier {
  int currentIndex = 0;
  CategoryBanners _banner = locator<CategoryBanners>();
  List<Swipebanner> list = [];

  autoPlay(PageController controller) {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentIndex < list.length - 1) {
        currentIndex++;
        notifyListeners();
      } else {
        currentIndex = 0;
        notifyListeners();
      }
      controller.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  onPageChange(int i) {
    currentIndex = i;
    notifyListeners();
  }

  Future fetchBanner() async {
    var result = await _banner.getSwipeBanners();
    if (result is List<Swipebanner>) {
      list = result;
      notifyListeners();
    } else {
      print(result);
    }
  }
}
