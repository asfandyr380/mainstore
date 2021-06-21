import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';
import 'package:main_store/View/root/root_app.dart';
import 'Config/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(RootWidget());
}
