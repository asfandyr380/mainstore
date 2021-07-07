import 'dart:convert';

import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:http/http.dart' as http;
import 'package:main_store/Services/Api/Wishlist/wishlist_Services.dart';

class NearbyProduct {
  WishServices _wish = locator<WishServices>();

  Future getProducts() async {
    List<ProductsModel> wishProducts = await _wish.getWishlist(6);
    List<ProductsModel> products = [];
    Uri _BaseURL = Uri.parse('$baseUrl/products/');
    http.Response res = await http.get(_BaseURL);
    List decodedBody = jsonDecode(res.body);
    // print(decodedBody);
    for (var body in decodedBody) {
      List<String> images = [];
      List<String> categories = [];
      List<AttributeModel> attributes = [];
      List attribute = body['Attribute'];

      images.add(body['Product']['image']);
      for (int i = 2; i <= 4; i++) {
        images.add(body['Product']['image$i']);
      }

      for (var att in attribute) {
        images.add(att['image']);
        var attribute = AttributeModel.fromJson(att);
        attributes.add(attribute);
      }

      categories.add(body['Product']['main_cate']);
      categories.add(body['Product']['cate_name']);
      categories.add(body['Product']['subCate_name'] ?? '');
      if (wishProducts.isNotEmpty) {
        var product;
        for (var list in wishProducts) {
          if (list.productId == body['Product']['id']) {
            product = ProductsModel.fromMap(
                body['Product'], images, categories, true, attributes);
          } else {
            product = ProductsModel.fromMap(
                body['Product'], images, categories, false, attributes);
          }
          products.add(product);
        }
      } else {
        var product = ProductsModel.fromMap(
            body['Product'], images, categories, false, attributes);
        products.add(product);
      }
    }
    products.sort((a, b) {
      if (b.onWishlist!)
        return 1;
      else
        return -1;
    });
    final ids = products.map((e) => e.productId).toSet();
    products.retainWhere((x) => ids.remove(x.productId));
    products.sort((a, b) => a.productPrice!.compareTo(b.productPrice!));
    return products;
  }
}
