import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Api/Wishlist/wishlist_Services.dart';

class OnSaleProducts {
  WishServices _wish = locator<WishServices>();
  

  Future getProducts(int page) async {
    var wishProducts = await _wish.userFavouriteProducts();

    List<ProductsModel> products = [];

    // Http Request
    Uri _baseURL = Uri.parse('$baseUrl/products/onSale');
    http.Response res = await http.get(_baseURL);
    var decodedBody = jsonDecode(res.body);

    // Computing Data
    for (var body in decodedBody['Products']) {
      List<String> images = [];
      List<String> categories = [];
      List<AttributeModel> attributes = [];

      List attribute = body['Attribute'];

      // Add Fist Image to Images
      String imgPath = body['Product']['image'];
      images.add('$baseUrl_Image/$imgPath');

      // Add Other 3 Images if available
      for (int i = 2; i <= 4; i++) {
        imgPath = body['Product']['image$i'];
        if (imgPath != '') {
          String image = '$baseUrl_Image/$imgPath';
          images.add(image);
        }
      }

      // Add Attributes if Available
      if (attribute.isNotEmpty) {
        for (var att in attribute) {
          imgPath = att['image'];
          String img = '$baseUrl_Image/$imgPath';
          if (imgPath != '') images.add(img);
          var attribute = AttributeModel.fromJson(att);
          attributes.add(attribute);
        }
      }
      
      // Add Available Categories Attached with Product
      categories.add(body['Product']['main_cate']);
      categories.add(body['Product']['cate_name'] ?? '');
      categories.add(body['Product']['subCate_name'] ?? '');

      //  Check for if Product is in Wishlist of User
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

    // Sorting Products From Low to High
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
