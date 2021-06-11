import 'package:flutter/services.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/categoryModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';

class GetCategorys {
  DocCollectionRef _ref = locator<DocCollectionRef>();

  Future getCategory() async {
    try {
      var result = await _ref.Categorys.get();
      if (result.docs.isNotEmpty) {
        return result.docs.map((e) async {
          var subCateResult =
              await _ref.Categorys.doc(e.id).collection('SubCategory').get();
          var subcatelist = subCateResult.docs
              .map(
                (e) => SubCategory.fromMap(
                  e.data(),
                ),
              )
              .toList();
          return CategoryModel.fromMap(e.data(), subcatelist);
        }).toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }
}
