import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_store/Models/productsModel.dart';

class FilterProducts {
  Future byCategory(List<String> categories) async {
    final Uri _OPTIONALURL = Uri.parse('http://localhost:3005/api/products/');
    List<ProductsModel> products = [];
    if (categories.isEmpty) {
      http.Response res = await http.get(_OPTIONALURL);
      List decodedBody = jsonDecode(res.body);
      for (var body in decodedBody) {
        List<String> images = [];
        List<String> categories = [];
        images.add(body['image']);
        for (int i = 2; i <= 4; i++) {
          images.add(body['image$i']);
        }
        categories.add(body['cate_name']);
        categories.add(body['subCate_name'] ?? '');
        var product = ProductsModel.fromMap(body, images, categories);
        products.add(product);
      }
    } else {
      for (var category in categories) {
        final Uri _URL =
            Uri.parse('http://localhost:3005/api/products/category');
        var reqBody = {'cate': category, 'subCate': category};
        http.Response res = await http.post(_URL, body: reqBody);
        List decodedBody = jsonDecode(res.body);
        // print(decodedBody);
        for (var body in decodedBody) {
          List<String> images = [];
          List<String> categories = [];
          images.add(body['image']);
          for (int i = 2; i <= 4; i++) {
            images.add(body['image$i']);
          }
          categories.add(body['cate_name']);
          categories.add(body['subCate_name'] ?? body['cate_name']);
          var product = ProductsModel.fromMap(body, images, categories);
          products.add(product);
        }
      }
    }
    return products;
  }
}
