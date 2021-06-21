import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Fireabase/Firestore/firestore_services.dart';

class Auth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirestoreServices _firestoreServices = locator<FirestoreServices>();

  // returns Fireabase Current User if Signed In
  Future<bool> currrentUser() async {
    return _firebaseAuth.currentUser != null;
  }

  Future<String> getUserId() async {
    return _firebaseAuth.currentUser!.uid;
  }

  // Sign In User
  Future signIn(String email, String password) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on PlatformException catch (ex) {
      return ex.message;
    }
  }

  // Create New User
  Future signUp(
      String email, String password, String name, String phone) async {
    try {
      var authresult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (authresult.user != null) {
        updateProfileDetails(authresult, name, phone, email);
        print(authresult.user);
      }
      // ignore: unnecessary_null_comparison
      return authresult != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on PlatformException catch (ex) {
      return ex.message;
    }
  }

  // Update User Name Email and Phone No While Siging Up
  updateProfileDetails(UserCredential userCredential, String name, String phone,
      String email) async {
    await userCredential.user!.updateProfile(
      displayName: name,
    );
    _firestoreServices.updateUserProfile(
      userCredential.user!.uid,
      name,
      email,
      phone,
    );
  }

  // Sign Out User
  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}
