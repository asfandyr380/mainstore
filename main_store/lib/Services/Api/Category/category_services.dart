import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Models/categoryModel.dart';

class CategoryServices {
  Future getCategorys() async {
    List<SubCategory> superCates = [];
    List<SubSubCategory> subCate = [];
    List<String> sub = [];
    List<CategoryModel> mainCates = [];
    Uri _url = Uri.parse('$baseUrl/categories/');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      print(data.length);
      for (var cate in data) {
        List superCate = cate['superCate'];
        for (var sCate in superCate) {
          List s = sCate['SubCate'];
          for (var name in s) {
            var subsub = SubSubCategory.fromMap(name['name']);
            subCate.add(subsub);
            sub.add(name['name']);
          }
          var sC = SubCategory.fromMap(sCate, subCate, sub);
          superCates.add(sC);
          subCate = [];
          sub = [];
        }
        var mainCate = CategoryModel.fromMap(cate, superCates);
        mainCates.add(mainCate);
        superCates = [];
      }
      return mainCates;
    }
  }
}
