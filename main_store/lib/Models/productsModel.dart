class ProductsModel {
  String? name = '';
  double? productPrice = 0;
  double? salePrice = 0;
  bool? onSale = false;
  String? description = '';
  List<String>? category = [];
  bool? status = false;
  List<String>? searckKey = [];
  String? by = '';
  List<String>? images = [];

  ProductsModel(
      {this.by,
      this.category,
      this.description,
      this.images,
      this.name,
      this.onSale,
      this.productPrice,
      this.salePrice,
      this.searckKey,
      this.status});

  ProductsModel.fromMap(Map<String, dynamic>? map)
      : name = map!['name'] ?? '',
        productPrice = map['productPrice'] ?? '',
        salePrice = map['salePrice'] ?? '',
        description = map['description'] ?? '',
        by = map['by'] ?? '',
        onSale = map['onSale'] ?? '',
        status = map['status'] ?? '',
        category = List.from(map['category']),
        searckKey = List.from(map['searchKey']),
        images = List.from(map['images']);
}
