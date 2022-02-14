import 'package:flutter/material.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Extention/string_externsion.dart';
import 'package:main_store/Models/SummeryModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/About_Us/AboutusView.dart';
import 'package:main_store/View/Cart/CartView.dart';
import 'package:main_store/View/CheckOut/CheckOutView.dart';
import 'package:main_store/View/Componants/contact_us/contactUsView.dart';
import 'package:main_store/View/ForgotPassword/ForgotPassword.dart';
import 'package:main_store/View/Home/home_view.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageView.dart';
import 'package:main_store/View/ProductDetail/productDetailView.dart';
import 'package:main_store/View/ProductListingPage/ProductListingPage.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';
import 'package:main_store/View/Sign_up/signup_view.dart';
import 'package:main_store/View/Splash%20Screen/Splash_screen.dart';
import 'package:main_store/View/SuccessPage/successPage.dart';
import 'package:main_store/View/UserDashboard/userDashboard.dart';
import 'package:main_store/View/Wish_List/wishlist.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name!.getRoutingData;
  var arg = settings.arguments;
  switch (routingData.route) {
    case SignIn:
      return _getPageRoute(SigninPage(), settings);
    case SignUp:
      return _getPageRoute(SignUpPage(), settings);
      ;
    case HomeView:
      return _getPageRoute(HomePage(), settings);
    case Cart:
      return _getPageRoute(CartView(), settings);
    case SuccessPage:
      var id = routingData['id'];
      return _getPageRoute(Success(id, routeData: routingData), settings);
    case Checkout:
      SummeryModel? details = arg as SummeryModel?;
      return _getPageRoute(CheckOutPage(m: details), settings);
    case LandingPageView:
      return _getPageRoute(LandingPage(), settings);
    case ContactUs:
      return _getPageRoute(ContactUsView(), settings);
    case AboutUs:
      return _getPageRoute(AboutView(), settings);
    case SplashScreenView:
      return _getPageRoute(SplashScreen(), settings);
    case Dashboard:
      return _getPageRoute(UserDashboard(), settings);
    case Wishlist:
      return _getPageRoute(WishlistView(), settings);
    case ForgotPassword:
      return _getPageRoute(ForgotPasswordView(), settings);
    case ProductDetailsPage:
      ProductsModel? details = arg as ProductsModel?;
      return _getPageRoute(
          ProductDetailView(productDetails: details!), settings);
    case ProductListing:
      dynamic cate = arg as dynamic;
      return _getPageRoute(ListingPage(cate: cate), settings);

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

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name!);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({required this.child, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}