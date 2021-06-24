import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  String productId = '';
  DocumentReference? reference = null;
  String? name = '';
  String? description = '';
  String? by = '';
  String? storeName = '';
  double? productPrice = 0;
  double? salePrice = 0;
  bool? onSale = false;
  bool? status = false;
  List<String>? category = [];
  List<String>? searckKey = [];
  List<String>? images = [];

  ProductsModel.fromMap(
      Map<String, dynamic>? map, String id, DocumentReference ref)
      : name = map!['name'] ?? '',
        productPrice = map['productPrice'] ?? '',
        salePrice = map['salePrice'] ?? '',
        description = map['description'] ?? '',
        by = map['by'] ?? '',
        onSale = map['onSale'] ?? '',
        status = map['status'] ?? '',
        category = List.from(map['category']),
        searckKey = List.from(map['searchKey']),
        images = List.from(map['images']),
        storeName = map['storeName'],
        reference = ref,
        productId = id;
}
