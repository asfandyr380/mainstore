import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/get_products.dart';

class ProductDetailViewModel extends ChangeNotifier {
  Products _products = locator<Products>();
  List<ProductsModel> relatedlist = [];

  fetchRelatedProduct(List<String> category) async {
    var result = await _products.relatedProducts(category);
    if (result is List<ProductsModel>) {
      relatedlist = result;
      notifyListeners();
    } else {
      print(result);
    }
  }
}
