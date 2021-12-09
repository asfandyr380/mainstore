import 'package:flutter/material.dart';
// import 'package:main_store/Config/consts.dart';
// import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/Banners.dart';
// import 'package:main_store/Services/Api/Banners/banner_Services.dart';

class BannersViewModel extends ChangeNotifier {
  // BannerServices _banner = locator<BannerServices>();
  List<Banners> bannerlist = [
    Banners(id: 1, image: "img_banner4-1-new.jpeg", mainText: "Fruits & Dried Fruits"),
    Banners(id: 2, image: "global-grocery-items-counter-ad0653ad.jpeg", mainText: "Grocery Items"),
    Banners(id: 3, image: "cosmetics.png", mainText: "Cosmetics"),
    Banners(id: 4, image: "frozen meat.png", mainText: "Frozen Meat"),
    Banners(id: 5, image: "img_banner4-3-new.jpeg", mainText: "Fresh Bread"),
    Banners(id: 6, image: "img_banner4-4-new.jpeg", mainText: "Fish & SeaFood"),
  ];

  // Future getBanners() async {
  //   try {
  //     var result = await _banner.getBanner();
  //     if (result is List<Banners>) {
  //       bannerlist = result;
  //       notifyListeners();
  //       if (bannerlist.isNotEmpty) {
  //         return bannerlist;
  //       }
  //     } else {
  //       print(result);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
