import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Models/productsModel.dart';

class SearchProductServices {
  Future seaerhForProduct(String searchKey) async {
    List<ProductsModel> products = [];
    if (searchKey != null && searchKey.isNotEmpty) {
      Map<String, dynamic> key = {'key': '%$searchKey%'};
      Uri url = Uri.parse('$baseUrl/products/search/');
      http.Response res = await http.post(url, body: key);
      var decodedBody = jsonDecode(res.body);
      // print(decodedBody);
      if (res.statusCode == 200) {
        for (var body in decodedBody) {
          List<String> images = [];
          List<String> categories = [];
          images.add(body['image']);
          for (int i = 2; i <= 4; i++) {
            images.add(body['image$i']);
          }
          categories.add(body['cate_name']);
          categories.add(body['subCate_name']);
          var product = ProductsModel.fromMap(body, images, categories, false);
          products.add(product);
        }
      }
    }
    return products;
  }
}
