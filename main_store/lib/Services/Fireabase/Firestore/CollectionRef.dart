import 'package:cloud_firestore/cloud_firestore.dart';

class DocCollectionRef {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get productRef => _firestore.collection("Products");
  CollectionReference get userRef => _firestore.collection("Users");
  CollectionReference get categoryBanners => _firestore.collection("Banners");
  CollectionReference get swipeBanner => _firestore.collection("SwipeBanners");
  CollectionReference get Brands => _firestore.collection("Brands");
  CollectionReference get Products => _firestore.collection("Products");
  CollectionReference get Stores => _firestore.collection("Stores");
  CollectionReference get Categorys => _firestore.collection("Categorys");
}
