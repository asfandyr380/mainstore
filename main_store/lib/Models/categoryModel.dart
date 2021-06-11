class CategoryModel {
  String? cateName = '';
  List<SubCategory> subCategory = [];
  CategoryModel({this.cateName, required this.subCategory});

  CategoryModel.fromMap(Map map, List<SubCategory>? subcate)
      : cateName = map['cateName'] ?? '',
        subCategory = subcate ?? [];
}

class SubCategory {
  String? cateName = '';
  List<String>? subCate = [];
  SubCategory({this.cateName, this.subCate});

  SubCategory.fromMap(Map map)
      : cateName = map['cateName'],
        subCate = List.from(map['subCate']);
}
