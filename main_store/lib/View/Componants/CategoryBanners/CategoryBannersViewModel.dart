import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/Banners.dart';
import 'package:main_store/Services/Api/Banners/banner_Services.dart';

class BannersViewModel extends ChangeNotifier {
  BannerServices _banner = locator<BannerServices>();
  List<Banners> bannerlist = [];

  Future getBanners() async {
    try {
      var result = await _banner.getBanner();
      if (result is List<Banners>) {
        bannerlist = result;
        notifyListeners();
        if (bannerlist.isNotEmpty) {
          return bannerlist;
        }
      } else {
        print(result);
      }
    } catch (e) {
      print(e);
    }
  }
}
