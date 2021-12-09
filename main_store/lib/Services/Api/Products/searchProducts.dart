import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Models/productsModel.dart';

class SearchProductServices {
  Future seaerhForProduct(String? searchKey) async {
    List<ProductsModel> products = [];
    // Check for Search String
    if (searchKey != null && searchKey.isNotEmpty) {
      // Http Request
      Map<String, dynamic> key = {'key': '%$searchKey%'};
      Uri url = Uri.parse('$baseUrl/products/search/');
      http.Response res = await http.post(url, body: key);
      var decodedBody = jsonDecode(res.body);

      // Computing Data
      if (res.statusCode == 200) {
        for (var body in decodedBody) {
          List<String> images = [];
          List<AttributeModel> attributes = [];
          List<String> categories = [];
          List attribute = body['Attribute'];

          // Add First Image to Images
          String imgPath = body['Product']['image'];
          String image = '$baseUrl_Image/$imgPath';
          images.add(image);

          // Add Other 3 Images if available
          for (int i = 2; i <= 4; i++) {
            imgPath = body['Product']['image$i'];
            if (imgPath != '') {
              String image = '$baseUrl_Image/$imgPath';
              images.add(image);
            }
          }

          // Add Attributes if Available
          for (var att in attribute) {
            String imgPath = att['image'];
            String img = '$baseUrl/products/getimg/$imgPath';
            images.add(img);
            var attribute = AttributeModel.fromJson(att);
            attributes.add(attribute);
          }

          // Add Available Categories Attached with Product
          categories.add(body['Product']['main_cate']);
          categories.add(body['Product']['cate_name'] ?? '');
          categories.add(body['Product']['subCate_name'] ?? '');
          
          var product = ProductsModel.fromMap(
              body['Product'], images, categories, false, attributes);
          products.add(product);
        }
      }
    }
    
    return products;
  }
}
