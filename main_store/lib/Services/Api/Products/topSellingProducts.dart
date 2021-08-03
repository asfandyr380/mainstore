import 'dart:convert';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:http/http.dart' as http;
import 'package:main_store/Services/Api/Wishlist/wishlist_Services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

class TopSelling {
  WishServices _wish = locator<WishServices>();
  StorageServices _services = locator<StorageServices>();
  int totalProducts = 0;

  Future getProducts(int page) async {
    List<ProductsModel> wishProducts = [];
    var user = await _services.getUser();
    var _userIp = await Ipify.ipv4();
    String i = _userIp.replaceAll('.', '');
    String newI = i.substring(i.length - 5);
    int ip = int.parse(newI);

    if (user) {
      int userId = await _services.getUserId();
      wishProducts = await _wish.getWishlist(userId);
    } else {
      wishProducts = await _wish.getWishlist(ip);
    }
    Uri _BaseURL = Uri.parse('$baseUrl/products/topSelling/0');
    List<ProductsModel> products = [];
    http.Response res = await http.get(_BaseURL);
    var decodedBody = jsonDecode(res.body);
    totalProducts = decodedBody['TotalProducts'];
    for (var body in decodedBody['Products']) {
      List<String> images = [];
      List<String> categories = [];
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
