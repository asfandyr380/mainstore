import 'package:main_store/Models/productsModel.dart';

class CartModel {
  int? quantity = 0;
  String? storeName = '';
  List<ProductsModel> products = [];
  List? ref = [];

  CartModel({this.quantity, this.storeName, required this.products, this.ref});

  CartModel.fromMap(Map map, List<ProductsModel> list, List ref)
      : quantity = map['quantity'] ?? 0,
        storeName = map['store'] ?? '',
        products = list,
        ref = map["products"];
}
