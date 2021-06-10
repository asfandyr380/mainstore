import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/availableProducts.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';

class Products {
  DocCollectionRef ref = locator<DocCollectionRef>();

  Future onSaleProducts() async {
    try {
      var result = await ref.Products.where('onSale', isEqualTo: true).get();
      if (result.docs.isNotEmpty) {
        return result.docs
            .map(
              (e) => ProductsModel.fromMap(e.data()),
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

  Future topSellingProducts() async {
    List<DocumentSnapshot> productResults = [];
    try {
      var result = await ref.Stores.get();
      if (result.docs.isNotEmpty) {
        var storeId = result.docs
            .map(
              (e) => AvailableProducts.fromMap(e.data(), e.id),
            )
            .toList();
        for (var product in storeId) {
          var availableProduct = await ref.Stores.doc(product.productId)
              .collection("AvailableProducts")
              .where('sold', isGreaterThanOrEqualTo: 5)
              .get();
          for (var product in availableProduct.docs) {
            var products = await ref.Products.doc(product.id).get();
            productResults.add(products);
          }
        }
        return productResults
            .map(
              (e) => ProductsModel.fromMap(e.data()),
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

  Future nearbyProducts() async {
    try {
      var result = await ref.Products.get();
      if (result.docs.isNotEmpty) {
        return result.docs
            .map(
              (e) => ProductsModel.fromMap(e.data()),
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
          await ref.Products.where('category', arrayContainsAny: category)
              .get();
      if (result.docs.isNotEmpty) {
        return result.docs
            .map(
              (e) => ProductsModel.fromMap(e.data()),
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
