import 'package:main_store/Models/productsModel.dart';

class CartModel {
  List<CartProducts> product = [];
  String storeName = '';
  bool? isSelected = false;
  CartModel.fromMap(List<CartProducts> cartProducts, String store)
      : product = cartProducts,
        storeName = store,
        isSelected = false;
}

class CartProducts {
  ProductsModel? products;
  int? quantity = 0;
  bool? isSelected = false;
  CartProducts.fromMap(Map map, ProductsModel product)
      : products = product,
        quantity = map['quantity'],
        isSelected = false;
}
