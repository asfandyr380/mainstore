// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:main_store/Config/locator.dart';
// import 'package:main_store/Models/productsModel.dart';
// import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
// import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';

// class WishListServices {
//   DocCollectionRef _ref = locator<DocCollectionRef>();
//   Auth _auth = locator<Auth>();

//   Future onWishList(String userId) async {
//     List ref = [];
//     var user = await _auth.currrentUser();
//     if (user) {
//       String userId = await _auth.getUserId();
//       var result = await _ref.userRef.doc(userId).get();
//       ref = result.data()!['wishlist'];
//     }
//     return ref;
//   }

//   Future addtoWishlist(String userId, DocumentReference ref) async {
//     try {
//       await _ref.userRef.doc(userId).update({
//         'wishlist': FieldValue.arrayUnion([ref])
//       }).then((value) => {
//             ref.update({'onWishlist': true})
//           });
//     } catch (e) {
//       if (e is PlatformException) {
//         return e.message;
//       } else {
//         return e;
//       }
//     }
//   }

//   Future getWishlist(String userId) async {
//     List<ProductsModel> list = [];
//     try {
//       var result = await _ref.userRef.doc(userId).get();
//       if (result.exists) {
//         var _ref = result.data()!['wishlist'];
//         for (DocumentReference ref in _ref) {
//           var product = await ref.get();
//           var products = ProductsModel.fromMap(product.data(), [], []);
//           list.add(products);
//         }
//         return list;
//       } else {
//         return result;
//       }
//     } catch (e) {
//       if (e is PlatformException) {
//         return e.message;
//       } else {
//         return e;
//       }
//     }
//   }
// }
