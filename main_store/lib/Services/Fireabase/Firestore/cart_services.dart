import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';

class CartServices {
  DocCollectionRef _ref = locator<DocCollectionRef>();

  Future getCartProducts(String userId) async {
    List<ProductsModel> _products = [];
    List<DocumentSnapshot> _snapshot = [];
    List productsRef = [];
    List<CartModel> cartslist = [];
    var result = await _ref.userRef.doc(userId).collection('Cart').get();
    if (result.docs.isNotEmpty) {
      for (var doc in result.docs) {
        productsRef = await doc.data()['products'];
        for (DocumentReference ref in productsRef) {
          var product = await ref.get();
          _snapshot.add(product);
        }
        for (var snap in _snapshot) {
          var productRes =
              ProductsModel.fromMap(snap.data(), snap.id, snap.reference);
          _products.add(productRes);
        }
        _snapshot = [];
        var cart = CartModel.fromMap(doc.data(), _products, productsRef);
        cartslist.add(cart);
        _products = [];
      }
      return cartslist;
    }
  }

  Future addtoCartCollection(var userId, DocumentReference productId,
      String? storeName, int quantity) async {
    try {
      await _ref.userRef
          .doc(userId)
          .collection('Cart')
          .doc(storeName)
          .get()
          .then((doc) async {
        if (doc.exists) {
          await _ref.userRef
              .doc(userId)
              .collection('Cart')
              .doc(storeName)
              .update({
            'products': FieldValue.arrayUnion([productId]),
          });
        } else {
          await _ref.userRef.doc(userId).collection('Cart').doc(storeName).set(
            {
              'products': [productId],
              'quantity': 0,
              'store': storeName,
            },
          );
        }
      });
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }
}
