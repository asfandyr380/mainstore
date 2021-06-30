import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Fireabase/Auth/firebase_auth.dart';
import 'package:main_store/Services/Fireabase/Firestore/Wishlist_services.dart';

class CardViewModel extends ChangeNotifier {
  WishListServices _wish = locator<WishListServices>();
  Auth _auth = locator<Auth>();

  Future addtoWishlist(DocumentReference ref) async {
    var user = await _auth.currrentUser();
    if (user) {
      String userId = await _auth.getUserId();
      await _wish.addtoWishlist(userId, ref);
    } else {}
  }
}
