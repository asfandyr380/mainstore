class BrandsModel {
  int? id = 0;
  String? brandName = '';
  String? image = '';
  int status = 0;

  BrandsModel({this.brandName, this.image});

  BrandsModel.fromMap(Map map)
      : id = map['store_Id'] ?? 0,
        brandName = map['store_name'] ?? '',
        status = map['store_status'],
        image = map['logo'];
}
