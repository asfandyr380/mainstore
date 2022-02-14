import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/Navigation/router.dart';
import 'package:main_store/View/Layout/layout.dart';

// This Widget is the Root of The Application
class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeView,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      onGenerateRoute: (settings) => generateRoute(settings),
      builder: (context, widget) => Layout(child: widget),
      navigatorKey: locator<Navigation>().navigationKey,
    );
  }
}
