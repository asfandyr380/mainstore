import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Config/routes.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';

class FooterViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();

  navigateToAbout() {
    _navigation.navigateTo(AboutUs);
  }

  navigateToHome() {
    _navigation.navigateTo(HomeView);
  }

  navigateToContact() {
    _navigation.navigateTo(ContactUs);
  }
}
