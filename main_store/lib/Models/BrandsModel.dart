class BrandsModel {
  int? id = 0;
  String? brandName = '';
  String? image = '';

  BrandsModel({this.brandName, this.image});

  BrandsModel.fromMap(Map map, String img)
      : id = map['store_Id'] ?? 0,
        brandName = map['store_name'] ?? '',
        image = img;
}
