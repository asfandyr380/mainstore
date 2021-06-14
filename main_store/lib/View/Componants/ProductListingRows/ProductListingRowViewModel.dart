import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ProductListingRowViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();
  int count = 4;
  int maxCount = 0;
  scrollBack(AutoScrollController controller, int listlength) async {
    maxCount = listlength;
    if (count > 0) {
      count--;
    }
    await controller.scrollToIndex(
      count,
      preferPosition: AutoScrollPosition.begin,
    );
    controller.notifyListeners();
    if (count >= maxCount) {
      count = 0;
    }
  }

  scrollNext(AutoScrollController controller, int listlength) async {
    maxCount = listlength;
    await controller.scrollToIndex(
      count,
      preferPosition: AutoScrollPosition.begin,
    );
    if (count >= maxCount) {
      count--;
    } else {
      count++;
    }

    controller.notifyListeners();
  }

  navigatetoDetailPage(ProductsModel? details) {
    _navigation.navigateTo(ProductDetailsPage, arguments: details);
  }
}
