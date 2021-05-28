import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/Navigation/router.dart';
import 'package:main_store/View/CheckOut/CheckOutView.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';
import 'package:main_store/View/Sign_up/signup_view.dart';

// This Widget is the Root of The Application
class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => generateRoute(settings),
      navigatorKey: locator<Navigation>().navigationKey,
      home: CheckOutPage(true),
    );
  }
}
