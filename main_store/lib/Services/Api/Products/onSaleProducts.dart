import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_store/Models/productsModel.dart';

class OnSaleProducts {
  Future getProducts() async {
    List<ProductsModel> products = [];
    Uri _BaseURL = Uri.parse('http://localhost:3005/api/products/onSale');
    http.Response res = await http.get(_BaseURL);
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
      categories.add(body['subCate_name']);
      var product = ProductsModel.fromMap(body, images, categories);
      products.add(product);
    }
    print(products);
    return products;
  }
}
