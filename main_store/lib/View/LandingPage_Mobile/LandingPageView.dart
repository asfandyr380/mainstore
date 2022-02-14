import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/View/Account/AccountView.dart';
import 'package:main_store/View/Cart/CartView.dart';
import 'package:main_store/View/Componants/SideNav/SideNavView.dart';
import 'package:main_store/View/Home/Views/home_mobile.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageViewModel.dart';
import 'package:main_store/View/SearchPage/SearchPageView.dart';
import 'package:main_store/View/Widgets/Mobile_AppBar.dart';
import 'package:stacked/stacked.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LandingPage extends StatelessWidget {
  final int? index;
  final bool? onSignIn;
  final bool? onSignUp;
  LandingPage({this.index, this.onSignIn, this.onSignUp});
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late PersistentTabController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: index ?? 0);
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Scaffold(
              key: scaffoldKey,
              drawer: Drawer(
                elevation: 16,
                child: SideNavMenu(state: true),
              ),
              appBar: mobileAppBar(scaffoldKey),
              body: PersistentTabView(
                context,
                controller: _controller,
                confineInSafeArea: true,
                screens: [
                  HomeMobile(),
                  SearchPage(),
                  CartMobileView(),
                  AccountView(
                    onSignIn: onSignIn,
                    onSignUp: onSignUp,
                  ),
                ],
                decoration: NavBarDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 6,
                    ),
                  ],
                ),
                items: _navBarsItems(),
                backgroundColor: Colors.white,
                handleAndroidBackButtonPress: true,
                stateManagement: true,
                hideNavigationBarWhenKeyboardShows: true,
              ),
            ),
        viewModelBuilder: () => LandingPageViewModel());
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(FontAwesomeIcons.home),
      title: ("Home"),
      activeColorPrimary: accentColor,
      inactiveColorPrimary: Colors.black.withOpacity(0.75),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(FontAwesomeIcons.search),
      title: ("Search"),
      activeColorPrimary: accentColor,
      inactiveColorPrimary: Colors.black.withOpacity(0.75),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(FontAwesomeIcons.shoppingCart),
      title: ("Cart"),
      activeColorPrimary: accentColor,
      inactiveColorPrimary: Colors.black.withOpacity(0.75),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(FontAwesomeIcons.userAlt),
      title: ("Account"),
      activeColorPrimary: accentColor,
      inactiveColorPrimary: Colors.black.withOpacity(0.75),
    ),
  ];
}
