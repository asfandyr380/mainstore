import 'package:flutter/material.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Models/SummeryModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/About_Us/AboutusView.dart';
import 'package:main_store/View/Cart/CartView.dart';
import 'package:main_store/View/CheckOut/CheckOutView.dart';
import 'package:main_store/View/Componants/contact_us/contactUsView.dart';
import 'package:main_store/View/ForgotPassword/ForgotPassword.dart';
import 'package:main_store/View/Home/HomeView.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageView.dart';
import 'package:main_store/View/ProductDetail/productDetailView.dart';
import 'package:main_store/View/ProductListingPage/ProductListingPage.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';
import 'package:main_store/View/Sign_up/signup_view.dart';
import 'package:main_store/View/Splash%20Screen/Splash_screen.dart';
import 'package:main_store/View/SuccessPage/successPage.dart';
import 'package:main_store/View/Wish_List/wishlist.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var arg = settings.arguments;
  switch (settings.name) {
    case SignIn:
      return _GeneratePageRoute(widget: SigninPage(), routeName: settings.name);
    case SignUp:
      return _GeneratePageRoute(widget: SignUpPage(), routeName: settings.name);
    case HomeView:
      return _GeneratePageRoute(widget: HomePage(), routeName: settings.name);
    case Cart:
      return _GeneratePageRoute(widget: CartView(), routeName: settings.name);
    case SuccessPage:
      return _GeneratePageRoute(widget: Success(), routeName: settings.name);
    case Checkout:
      SummeryModel? details = arg as SummeryModel?;
      return _GeneratePageRoute(
          widget: CheckoutPage(m: details), routeName: settings.name);
    case LandingPageView:
      return _GeneratePageRoute(
          widget: LandingPage(), routeName: settings.name);
    case ContactUs:
      return _GeneratePageRoute(
          widget: ContactUsView(), routeName: settings.name);
    case AboutUs:
      return _GeneratePageRoute(widget: AboutView(), routeName: settings.name);
    case SplashScreenView:
      return _GeneratePageRoute(
          widget: SplashScreen(), routeName: settings.name);
    case Wishlist:
      return _GeneratePageRoute(
          widget: WishlistView(), routeName: settings.name);
    case ForgotPassword:
      return _GeneratePageRoute(
          widget: ForgotPasswordView(), routeName: settings.name);
    case ProductDetailsPage:
      ProductsModel? details = arg as ProductsModel?;
      return _GeneratePageRoute(
          widget: ProductDetailPage(
            productDetails: details!,
          ),
          routeName: settings.name);
    case ProductListing:
      dynamic cate = arg as dynamic;
      return _GeneratePageRoute(
          widget: ListingPage(
            cate: cate,
          ),
          routeName: settings.name);

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
