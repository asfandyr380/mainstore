import 'dart:async';

import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/swipeBanner.dart';
import 'package:main_store/Services/Api/Banners/banner_Services.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_banners.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class SwipeBannerViewModel extends ChangeNotifier {
  int currentIndex = 0;
  BannerServices _banner = locator<BannerServices>();
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

  Navigation _navigation = locator<Navigation>();
  navigateToProductlisting(String cate) async {
    print(cate);
    _navigation.navigateTo(ProductListing, arguments: [cate]);
  }

  Future fetchBanner() async {
    var result = await _banner.fetchSwipeBanners();
    if (result is List<Swipebanner>) {
      list = result;
      notifyListeners();
    } else {
      print(result);
    }
  }
}
