class CategoryModel {
  String? mainCate = '';
  List<SubCategory> superCate = [];
  CategoryModel({this.mainCate, required this.superCate});

  CategoryModel.fromMap(Map map, List<SubCategory>? subcate)
      : mainCate = map['MainCate'] ?? '',
        superCate = subcate ?? [];
}

class SubCategory {
  String? cateName = '';
  List<String>? subCate = [];
  SubCategory({this.cateName, this.subCate});

  SubCategory.fromMap(Map map, List<String>? subCate)
      : cateName = map['Name'],
        subCate = subCate ?? [];
}
