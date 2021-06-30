import 'dart:async';
import 'package:flutter/services.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';

import 'Wishlist_services.dart';

class CartServices {
  DocCollectionRef _ref = locator<DocCollectionRef>();

  Future getCartCount(String userId) async {
    var result = await _ref.userRef.doc(userId).collection('Cart').get();
    return result.docs.length;
  }

  Future getCartProducts(String userId) async {
    // TODO Fetch Realtime Data From Backend

    List<CartProducts> cartProducts = [];
    List<CartModel> cartlist = [];
    var result = await _ref.userRef.doc(userId).collection('Cart').get();
    if (result.docs.isNotEmpty) {
      for (var doc in result.docs) {
        var carts = await _ref.userRef
            .doc(userId)
            .collection('Cart')
            .doc(doc.id)
            .collection('CartProducts')
            .get();
        if (carts.docs.isEmpty) {
          await _ref.userRef
              .doc(userId)
              .collection('Cart')
              .doc(doc.id)
              .delete();
        }
        for (var cart in carts.docs) {
          var res = await _ref.Products.doc(cart.id).get();
          var product = ProductsModel.fromMap(res.data(), [], []);
          var cartProduct = CartProducts.fromMap(cart.data(), product);
          cartProducts.add(cartProduct);
        }
        var cart = CartModel.fromMap(cartProducts, doc.id);
        cartlist.add(cart);
        cartProducts = [];
      }
      return cartlist;
    }
  }

  Future addtoCartCollection(
      var userId, String productId, String? storeName, int quantity) async {
    try {
      await _ref.userRef
          .doc(userId)
          .collection('Cart')
          .doc(storeName)
          .set({'store': storeName}).then((value) async {
        await _ref.userRef
            .doc(userId)
            .collection('Cart')
            .doc(storeName)
            .collection('CartProducts')
            .doc(productId)
            .set({'quantity': quantity});
      });
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future removefromcart(
      String userId, String storeName, String productId) async {
    try {
      await _ref.userRef
          .doc(userId)
          .collection('Cart')
          .doc(storeName)
          .collection('CartProducts')
          .doc(productId)
          .delete();
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }
}
