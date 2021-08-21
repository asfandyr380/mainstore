class ProductsModel {
  int productId = 0;
  int storeId = 0;
  String? name = '';
  String? description = '';
  String? by = '';
  double? productPrice = 0;
  int? attributePrice = 0;
  double? salePrice = 0;
  int? onSale = 0;
  int? status = 1;
  List<String>? category = [];
  List<String>? images = [];
  List<AttributeModel> attributes = [];
  bool? onWishlist = false;

  ProductsModel.fromMap(Map<String, dynamic>? map, List<String>? images,
      List<String>? categories, bool onlist, List<AttributeModel> attributelist)
      : name = map!['name'] ?? '',
        productPrice = map['price'],
        salePrice = map['salePrice'],
        description = map['description'] ?? '',
        by = map['store_name'] ?? '',
        onSale = map['onSale'] ?? 0,
        status = map['status'] ?? 0,
        attributePrice = map['attributePrice'],
        category = categories ?? [],
        images = images ?? [],
        productId = map['id'],
        storeId = map['store_Id'],
        onWishlist = onlist,
        attributes = attributelist;
}

class AttributeModel {
  int id = 0;
  int stock = 0;
  String variant = '';
  int price = 0;
  String image = '';
  bool isSelected = false;

  AttributeModel.fromJson(Map map)
      : id = map['attribute_Id'],
        stock = map['stock'],
        variant = map['variant'],
        price = map['price'],
        image = map['image'] ?? '',
        isSelected = false;
}
