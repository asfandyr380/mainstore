class BrandsModel {
  String? brandName = '';
  String? image = '';

  BrandsModel({this.brandName, this.image});

  BrandsModel.fromMap(Map map)
      : brandName = map['brandName'] ?? '',
        image = map['image'] ?? '';
}
