import 'package:flutter/material.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Cart/CartView.dart';
import 'package:main_store/View/CheckOut/CheckOutView.dart';
import 'package:main_store/View/Home/HomeView.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageView.dart';
import 'package:main_store/View/ProductDetail/productDetailView.dart';
import 'package:main_store/View/ProductListingPage/ProductListingPage.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';
import 'package:main_store/View/Sign_up/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var arg = settings.arguments;
  switch (settings.name) {
    case SignIn:
      return _GeneratePageRoute(widget: SignInPage(), routeName: settings.name);
    case SignUp:
      return _GeneratePageRoute(widget: SignupPage(), routeName: settings.name);
    case HomeView:
      return _GeneratePageRoute(widget: Home(), routeName: settings.name);
    case Cart:
      return _GeneratePageRoute(
          widget: CartViewPage(), routeName: settings.name);
    case Checkout:
      return _GeneratePageRoute(
          widget: CheckOutPage(), routeName: settings.name);
    case LandingPageView:
      return _GeneratePageRoute(
          widget: LandingPage(), routeName: settings.name);
    case ProductDetailsPage:
      ProductsModel? details = arg as ProductsModel?;
      return _GeneratePageRoute(
          widget: ProductDetailView(
            productDetails: details!,
          ),
          routeName: settings.name);
    case ProductListing:
      return _GeneratePageRoute(
          widget: ProductListingPage(), routeName: settings.name);

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
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: child,
              );
            });
}
