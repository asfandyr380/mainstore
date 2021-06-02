import 'package:flutter/services.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Fireabase/Firestore/CollectionRef.dart';

class FirestoreServices {
  DocCollectionRef ref = locator<DocCollectionRef>();

  Future updateUserProfile(
      String userUid, String username, String email, String phone) async {
    try {
      await ref.userRef
          .doc(userUid)
          .set({"Username": username, "email": email, 'phone': phone});
    } catch (e) {
      if (e is PlatformException)
        return e.message;
      else
        return e;
    }
  }
}
