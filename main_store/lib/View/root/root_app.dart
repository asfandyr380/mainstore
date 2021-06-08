import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/Navigation/router.dart';
import 'package:main_store/View/Componants/Dialog/DialogView.dart';
import 'package:main_store/View/Home/HomeView.dart';
import 'package:main_store/View/ProductDetail/productDetailView.dart';

// This Widget is the Root of The Application
class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeView,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.latoTextTheme()),
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
