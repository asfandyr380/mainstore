import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/Navigation/router.dart';
import 'package:main_store/View/Account/AccountView.dart';
import 'package:main_store/View/AdminConsole/adminConsoleView.dart';
import 'package:main_store/View/Cart/CartView.dart';
import 'package:main_store/View/CheckOut/CheckOutView.dart';
import 'package:main_store/View/Componants/Dialog/DialogView.dart';
import 'package:main_store/View/Componants/contact_us/contactUsView.dart';
import 'package:main_store/View/Home/HomeView.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageView.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageViewModel.dart';
import 'package:main_store/View/ProductDetail/productDetailView.dart';
import 'package:main_store/View/ProductListingPage/ProductListingPage.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';
import 'package:main_store/View/Sign_up/signup_view.dart';
import 'package:main_store/View/UserDashboard/userDashboard.dart';
import 'package:main_store/View/UserDashboard/userInvoice.dart';
import 'package:main_store/View/UserDashboard/userOrder.dart';
import 'package:main_store/View/Widgets/SearchWidget/SearchBarRow.dart';

// This Widget is the Root of The Application
class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: UserOrder(),
      initialRoute: HomeView,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      onGenerateRoute: (settings) => generateRoute(settings),
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(
            child: widget!,
          ),
        ),
      ),
      navigatorKey: locator<Navigation>().navigationKey,
    );
  }
}
