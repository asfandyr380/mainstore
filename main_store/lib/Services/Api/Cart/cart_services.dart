import 'dart:convert';
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

  Future addToCart(int productId, int storeId, int userId, int quantity,
      String attributePrice) async {
    Uri _URL = Uri.parse('$baseUrl/cart/add/');
    Map<String, dynamic> req = {
      "product_Id": productId.toString(),
      "store_Id": storeId.toString(),
      "user_Id": userId.toString(),
      "quantity": quantity.toString(),
      "attributePrice": attributePrice.toString()
    };

    http.Response res = await http.post(_URL, body: req);
    var decodedBody = jsonDecode(res.body);
    print(decodedBody);
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

        String imgPath = product['image'];
        String image = '$baseUrl/products/getimage/$imgPath';
        images.add(image);
        for (int i = 2; i <= 4; i++) {
          String imgPath = product['image$i'];
          String image = '$baseUrl/products/getimage/$imgPath';
          images.add(image);
        }

        categories.add(product['cate_name']);
        categories.add(product['subCate_name'] ?? '');
        var pro = ProductsModel.fromMap(product, images, categories, false, []);
        var cartProduct = CartProducts.fromMap(product, pro);
        cartProducts.add(cartProduct);
      }

      var cart = CartModel.fromMap(cartProducts, body['store_Name']);
      carts.add(cart);
      cartProducts = [];
    }
    return carts;
  }

  Future checkoutProduct(
    int userId,
    double grandtotal,
    double subTotal,
    String address,
    String postalCode,
    String username,
  ) async {
    Uri url = Uri.parse('$baseUrl/checkout/');
    Map<String, dynamic> reqBody = {
      "user_Id": userId.toString(),
      "coupon_Id": '1',
      "subTotal": subTotal.toString(),
      "grandtotal": grandtotal.toString(),
      "payment_status": '0',
      "checkout_status": '1',
      "quentity": "0", // not needed
    };

    http.Response res = await http.post(url, body: reqBody);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1) {
      return decodedBody['data']['insertId'];
    } else {
      print(decodedBody);
      return false;
    }
  }

  Future createOrder(Map<String, dynamic> reqBody) async {
    Uri url = Uri.parse('$baseUrl/orders');
    http.Response res = await http.post(url, body: reqBody);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1) {
      return decodedBody['data']['insertId'];
    } else {
      print(decodedBody);
      return false;
    }
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

  Future updateCartStatus(String cartId, String orderId) async {
    Uri _BaseURL = Uri.parse('$baseUrl/cart/update/');
    Map<String, dynamic> reqBody = {
      'cart_status': "1",
      'cartId': cartId,
      'orderId': orderId,
    };
    http.Response res = await http.put(_BaseURL, body: reqBody);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future createCheckoutSession(
    List<Map> items,
    String checkoutId,
    String username,
    String postal,
    String address,
    List<int> ids,
  ) async {
    Uri _BaseURL = Uri.parse('$baseUrl/orders/paymentIntent');
    Map<String, dynamic> reqBody = {
      'items': items,
      "checkoutId": checkoutId,
      "username": username,
      'postal': postal,
      "address": address,
      'ids': ids,
    };
    http.Response res = await http.post(_BaseURL,
        body: jsonEncode(reqBody),
        headers: {
          "Accept": "application/json",
          'Content-type': 'application/json'
        });
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1) {
      return decodedBody['data']["id"];
    } else {
      return false;
    }
  }

  Future updateCheckoutStatus(String id) async {
    Uri _BaseURL = Uri.parse('$baseUrl/checkout/update');
    Map<String, dynamic> reqBody = {'id': id, 'status': '1'};
    http.Response res = await http.post(_BaseURL, body: reqBody);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future checkOrder(String checkoutId) async {
    Uri _BaseURL = Uri.parse('$baseUrl/orders/checkOrder/$checkoutId');
    http.Response res = await http.get(_BaseURL);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1) {
      return decodedBody['data'];
    } else {
      return false;
    }
  }
}
