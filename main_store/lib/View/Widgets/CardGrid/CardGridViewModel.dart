import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class CardGridViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();

  navigatetodetails(ProductsModel category) {
    _navigation.navigateTo(ProductDetailsPage, arguments: category);
  }
}
