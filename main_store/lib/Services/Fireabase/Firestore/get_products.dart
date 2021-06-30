import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/services.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/availableProducts.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';
import 'package:main_store/Services/Fireabase/Firestore/Wishlist_services.dart';

class Products {
  DocCollectionRef _ref = locator<DocCollectionRef>();
  Auth _auth = locator<Auth>();
  WishListServices _wish = locator<WishListServices>();

  Future getStoreProducts() async {
    List<String> _docIds = [];
    try {
      var result =
          await _ref.Stores.where('storeStatus', isEqualTo: true).get();
      if (result.docs.isNotEmpty) {
        var storeId = result.docs
            .map(
              (e) => AvailableProducts.fromMap(
                e.data(),
                e.id,
              ),
            )
            .toList();
        for (var product in storeId) {
          var availableProduct = await _ref.Stores.doc(product.productId)
              .collection("AvailableProducts")
              .get();
          if (availableProduct.docs.isNotEmpty) {
            for (var product in availableProduct.docs) {
              _docIds.add(product.id);
            }
          }
        }
        return _docIds;
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future productsbyFilter(
      var start, var end, var category, var descending) async {
    try {
      var result =
          await _ref.Stores.where('storeStatus', isEqualTo: true).get();
      var prodcutResult =
          await _ref.Products.orderBy('productPrice', descending: descending)
              .where('status', isEqualTo: true)
              .where('productPrice', isGreaterThanOrEqualTo: start)
              .where("productPrice", isLessThanOrEqualTo: end)
              .where('category', arrayContains: category)
              .get();
      if (result.docs.isNotEmpty) {
        var storeId = result.docs
            .map(
              (e) => AvailableProducts.fromMap(e.data(), e.id),
            )
            .toList();
        for (var product in storeId) {
          var availableProduct = await _ref.Stores.doc(product.productId)
              .collection("AvailableProducts")
              .get();
          for (var product in availableProduct.docs) {
            for (var res in prodcutResult.docs) {
              if (product.id == res.id) {
                return prodcutResult.docs
                    .map(
                      (e) => ProductsModel.fromMap(e.data(), [], []),
                    )
                    .toList();
              }
            }
          }
        }
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future onSaleProducts(List<String> doclist) async {
    List<DocumentSnapshot> doc = [];
    try {
      if (doclist.isNotEmpty) {
        for (var id in doclist) {
          var result = await _ref.Products.doc(id).get();
          if (result.data()!['status'] && result.data()!['onSale']) {
            doc.add(result);
          }
        }
        return doc
            .map(
              (e) => ProductsModel.fromMap(e.data(), [], []),
            )
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future topSellingProducts(List<String> doclist) async {
    List<DocumentSnapshot> _productResults = [];
    try {
      var result =
          await _ref.Stores.where('storeStatus', isEqualTo: true).get();
      if (result.docs.isNotEmpty) {
        var storeId = result.docs
            .map(
              (e) => AvailableProducts.fromMap(e.data(), e.id),
            )
            .toList();
        for (var product in storeId) {
          var availableProduct = await _ref.Stores.doc(product.productId)
              .collection("AvailableProducts")
              .where('sold', isGreaterThanOrEqualTo: 5)
              .get();
          for (var product in availableProduct.docs) {
            var products = await _ref.Products.doc(product.id).get();
            _productResults.add(products);
          }
        }
        return _productResults
            .map(
              (e) => ProductsModel.fromMap(e.data(), [], []),
            )
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future nearbyProducts(List<String> doclist) async {
    // TODO: Fetch Data Based on Location
    List<DocumentSnapshot> _doclist = [];
    try {
      if (doclist.isNotEmpty) {
        for (var id in doclist) {
          print(id);
          var result = await _ref.Products.doc(id).get();
          if (result.data()!['status'] == true) {
            _doclist.add(result);
          }
        }
        return _doclist
            .map(
              (e) => ProductsModel.fromMap(e.data(), [], []),
            )
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future relatedProducts(List<String> category) async {
    try {
      var result =
          await _ref.Products.where('category', arrayContainsAny: category)
              .orderBy('productPrice')
              .get();
      if (result.docs.isNotEmpty) {
        return result.docs
            .map(
              (e) => ProductsModel.fromMap(e.data(), [], []),
            )
            .toList();
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
