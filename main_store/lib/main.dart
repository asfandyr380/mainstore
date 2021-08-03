import 'package:flutter/material.dart';
import 'package:main_store/View/root/root_app.dart';
import 'Config/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(RootWidget());
}
