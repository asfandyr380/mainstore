import 'package:flutter/material.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/View/Home/HomeView.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';
import 'package:main_store/View/Sign_up/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignIn:
      return _GeneratePageRoute(widget: SignInPage(), routeName: settings.name);
    case SignUp:
      return _GeneratePageRoute(widget: SignupPage(), routeName: settings.name);
    case HomeView:
      return _GeneratePageRoute(widget: Home(), routeName: settings.name);

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

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String? routeName;
  _GeneratePageRoute({required this.widget, this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
