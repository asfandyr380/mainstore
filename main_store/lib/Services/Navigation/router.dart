import 'package:flutter/material.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';
import 'package:main_store/View/Sign_up/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignIn:
      return MaterialPageRoute(builder: (context) => SignInPage());
    case SignUp:
      return MaterialPageRoute(builder: (context) => SignupPage());

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
