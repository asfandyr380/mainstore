import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_store/Models/productsModel.dart';

class CartService {
  Future getCartProducts(int userId) async {
    List products = [];
    List stores = [];
    Uri _BaseURL = Uri.parse('http://localhost:3005/api/cart/$userId');
    http.Response res = await http.get(_BaseURL);
    List decodedBody = jsonDecode(res.body);
    print(decodedBody);
  }
}
