import 'package:flutter/material.dart';
import 'package:main_store/Models/Banners.dart';

class HomeViewModel extends ChangeNotifier {
  List<Banners> banner = [];

  getBanner(List<Banners> banners) {
    banner = banners;
    notifyListeners();
  }
}
