import 'package:main_store/Models/productsModel.dart';

class CartModel {
  List<CartProducts> product = [];
  String storeName = '';
  CartModel.fromMap(List<CartProducts> cartProducts, String store)
      : product = cartProducts,
        storeName = store;
}

class CartProducts {
  ProductsModel? products;
  int? quantity = 0;

  CartProducts.fromMap(Map map, ProductsModel product)
      : products = product,
        quantity = map['quantity'];
}
