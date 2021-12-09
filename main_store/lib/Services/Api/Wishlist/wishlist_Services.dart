import 'dart:convert';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:http/http.dart' as http;
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

class WishServices {
  StorageServices _services = locator<StorageServices>();

  Future WishProductCount(int userId) async {
    Uri wishUrl = Uri.parse('$baseUrl/wishlist/count/$userId');
    http.Response res = await http.get(wishUrl);
    var decodedBody = jsonDecode(res.body);
    print(decodedBody);
    if (res.statusCode == 200 && decodedBody.isNotEmpty) {
      return decodedBody[0]['totalProduct'];
    } else {
      return 0;
    }
  }

  Future addToWishlist(int userId, int productId) async {
    Uri wishUrl = Uri.parse('$baseUrl/wishlist/');
    Map<String, dynamic> req = {
      "user_Id": userId.toString(),
      "product_Id": productId.toString()
    };
    http.Response res = await http.post(wishUrl, body: req);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future getWishlist(int userId) async {
    Uri wishUrl = Uri.parse('$baseUrl/wishlist/$userId');
    List<ProductsModel> products = [];
    http.Response res = await http.get(wishUrl);
    List decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody.isNotEmpty) {
      for (var body in decodedBody) {
        List<String> images = [];
        List<String> categories = [];
        String imgPath = body['image'];
        String image = '$baseUrl/products/getimage/$imgPath';
        images.add(image);
        for (int i = 2; i <= 4; i++) {
          String imgPath = body['image$i'];
          String image = '$baseUrl/products/getimage/$imgPath';
          images.add(image);
        }

        categories.add(body['cate_name']);
        categories.add(body['subCate_name'] ?? '');
        var product =
            ProductsModel.fromMap(body, images, categories, false, []);
        products.add(product);
      }
    }
    return products;
  }

  Future removeFromWish(int id) async {
    Uri wishUrl = Uri.parse('$baseUrl/wishlist/remove/$id');
    http.Response res = await http.get(wishUrl);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ProductsModel>> userFavouriteProducts() async {
    List<ProductsModel> wishProducts = [];
    String _userIp = await Ipify.ipv4();
    bool user = await _services.getUser();
    String i = _userIp.replaceAll('.', '');
    String newI = i.substring(i.length - 5);
    int ip = int.parse(newI);
    if (user) {
      int userId = await _services.getUserId();
      wishProducts = await getWishlist(userId);
    } else {
      wishProducts = await getWishlist(ip);
    }
    return wishProducts;
  }
}
