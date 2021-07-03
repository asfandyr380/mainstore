import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/Models/productsModel.dart';

class CartService {
  Future cartProductCount(int userId) async {
    Uri wishUrl = Uri.parse('$baseUrl/cart/count/$userId');
    http.Response res = await http.get(wishUrl);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody.isNotEmpty) {
      return decodedBody[0]['totalProduct'];
    } else {
      return 0;
    }
  }

  Future addToCart(int productId, int storeId, int userId, int quantity) async {
    Uri _URL = Uri.parse('$baseUrl/cart/add/');
    Map<String, dynamic> req = {
      "product_Id": productId.toString(),
      "store_Id": storeId.toString(),
      "user_Id": userId.toString(),
      "quantity": quantity.toString()
    };

    http.Response res = await http.post(_URL, body: req);
    var decodedBody = jsonDecode(res.body);
    // print(decodedBody);
    if (decodedBody['success'] == 1) {
      print(decodedBody);
      return 1;
    } else {
      return 0;
    }
  }

  Future getCartProducts(int userId) async {
    List<CartProducts> cartProducts = [];
    List<CartModel> carts = [];
    Uri _BaseURL = Uri.parse('$baseUrl/cart/$userId');
    http.Response res = await http.get(_BaseURL);
    List decodedBody = jsonDecode(res.body);
    for (var body in decodedBody) {
      List products = body['Products'];
      for (var product in products) {
        List<String> images = [];
        List<String> categories = [];
        images.add(product['image']);
        for (int i = 2; i <= 4; i++) {
          images.add(product['image$i']);
        }
        categories.add(product['cate_name']);
        categories.add(product['subCate_name'] ?? '');
        var pro = ProductsModel.fromMap(product, images, categories, false);
        var cartProduct = CartProducts.fromMap(product, pro);
        cartProducts.add(cartProduct);
      }

      var cart = CartModel.fromMap(cartProducts, body['store_Name']);
      carts.add(cart);
      cartProducts = [];
    }

    return carts;
  }

  Future deleteFromCart(int cart_Id) async {
    Uri _BaseURL = Uri.parse('$baseUrl/cart/$cart_Id');
    http.Response res = await http.delete(_BaseURL);
    print(res.body);
    var decodedBody = jsonDecode(res.body);
    print(decodedBody['success']);
    if (decodedBody['success'] == 1)
      return true;
    else
      return false;
  }
}
