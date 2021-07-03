import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  int productId = 0;
  int storeId = 0;
  String? name = '';
  String? description = '';
  String? by = '';
  double? productPrice = 0;
  double? salePrice = 0;
  int? onSale = 0;
  int? status = 1;
  List<String>? category = [];
  List<String>? images = [];
  bool? onWishlist = false;

  ProductsModel.fromMap(Map<String, dynamic>? map, List<String>? images,
      List<String>? categories, bool onlist)
      : name = map!['name'] ?? '',
        productPrice = map['price'] ?? 0,
        salePrice = map['salePrice'] ?? 0,
        description = map['description'] ?? '',
        by = map['store_name'] ?? '',
        onSale = map['onSale'] ?? 0,
        status = map['status'] ?? 0,
        category = categories ?? [],
        images = images ?? [],
        productId = map['id'],
        storeId = map['store_Id'],
        onWishlist = onlist;
}
