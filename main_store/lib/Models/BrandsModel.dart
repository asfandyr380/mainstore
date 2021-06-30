class BrandsModel {
  int? id = 0;
  String? brandName = '';
  String? image = '';

  BrandsModel({this.brandName, this.image});

  BrandsModel.fromMap(Map map)
      : id = map['id'] ?? 0,
        brandName = map['brandName'] ?? '',
        image = map['image'] ?? '';
}
