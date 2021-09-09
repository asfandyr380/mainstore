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
  bool? isSelected = false;
  List<String>? subCate = [];
  List<SubSubCategory>? sub = [];

  SubCategory.fromMap(Map map, List<SubSubCategory>? sub, List<String>? subCate)
      : cateName = map['Name'],
        sub = sub ?? [],
        subCate = subCate ?? [],
        isSelected = false;
}

class SubSubCategory {
  String? cateName = '';
  bool? isSelected = false;

  SubSubCategory.fromMap(
    String map,
  )   : cateName = map,
        isSelected = false;
}
