import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class BannerViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();
  navigateToProductlisting(String cate) async {
    print(cate);
    _navigation.navigateTo(ProductListing, arguments: [cate]);
  }
}
