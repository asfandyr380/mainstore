import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Auth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
      var result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credential) =>
              updateProfileName(credential, name, phone, email));
      return result.user != null;
    } on FirebaseException catch (e) {
      return e.message;
    } catch (e) {
      return e;
    }
  }

  // Update User Name Email and Phone No While Siging Up
  updateProfileName(UserCredential userCredential, String name, String phone,
      String email) async {
    await userCredential.user!.updateProfile(
      displayName: name,
    );
    // TODO Create New User to The Users Collection
  }

  // Sign Out User
  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}
