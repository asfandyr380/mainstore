import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Models/productsModel.dart';

class SearchProductServices {
  Future seaerhForProduct(String? searchKey) async {
    List<ProductsModel> products = [];
    if (searchKey != null && searchKey.isNotEmpty) {
      Map<String, dynamic> key = {'key': '%$searchKey%'};
      Uri url = Uri.parse('$baseUrl/products/search/');
      http.Response res = await http.post(url, body: key);
      var decodedBody = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var body in decodedBody) {
          List<String> images = [];
          List<AttributeModel> attributes = [];
          List attribute = body['Attribute'];
          String imgPath = body['Product']['image'];
          String image = '$baseUrl/products/getimage/$imgPath';
          images.add(image);
          for (int i = 2; i <= 4; i++) {
            String imgPath = body['Product']['image$i'];
            String image = '$baseUrl/products/getimage/$imgPath';
            images.add(image);
          }
          for (var att in attribute) {
            String imgPath = att['image'];
            String img = '$baseUrl/products/getimg/$imgPath';
            images.add(img);
            var attribute = AttributeModel.fromJson(att);
            attributes.add(attribute);
          }
          List<String> categories = [];

          categories.add(body['Product']['main_cate']);
          categories.add(body['Product']['cate_name']);
          categories.add(body['Product']['subCate_name']);
          var product = ProductsModel.fromMap(
              body['Product'], images, categories, false, attributes);
          products.add(product);
        }
      }
    }
    return products;
  }
}
