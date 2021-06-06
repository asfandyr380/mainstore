import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DocCollectionRef {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get productRef => _firestore.collection("Products");
  CollectionReference get userRef => _firestore.collection("Users");
  CollectionReference get categoryBanners => _firestore.collection("Banners");
  CollectionReference get swipeBanner => _firestore.collection("SwipeBanners");
}
