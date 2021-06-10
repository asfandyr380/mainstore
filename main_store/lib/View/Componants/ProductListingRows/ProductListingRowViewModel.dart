import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ProductListingRowViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();

  scrolltoIndex(AutoScrollController controller, int index) async {
    await controller.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );
    controller.notifyListeners();
  }

  navigatetoDetailPage(ProductsModel? details) {
    _navigation.navigateTo(ProductDetailsPage, arguments: details);
  }
}
