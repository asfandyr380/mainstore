import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class SplashViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();

  navigateToHome() {
    Future.delayed(Duration(seconds: 2), () {
      _navigation.navigateTo(HomeView);
    });
  }
}
