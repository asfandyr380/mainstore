import 'package:flutter/services.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';

class AddProducts {
  DocCollectionRef _ref = locator<DocCollectionRef>();

  // Future addtoCartCollection(var userId, var productId) async {
  //   try {
  //     var result = await _ref.userRef.doc(userId).collection('Cart').doc(productId).set({});

  //   } catch (e) {
  //     if (e is PlatformException) {
  //       return e.message;
  //     } else {
  //       return e;
  //     }
  //   }
  // }
}
