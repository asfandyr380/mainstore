import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Account/AccountView.dart';
import 'package:main_store/View/CheckOut/CheckOutView.dart';
import 'package:main_store/View/Home/HomeView.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageViewModel.dart';
import 'package:main_store/View/SearchPage/SearchPageView.dart';
import 'package:stacked/stacked.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Scaffold(
              body: Column(
                children: [
                  //TODO: Appbar comes here
                  Expanded(
                    // width: double.infinity,
                    // height: SizeConfig.blockSizeVertical * 20,
                    child: PersistentTabView(
                      context,
                      confineInSafeArea: true,
                      screens: [
                        Homemobile(),
                        SearchPage(),
                        CheckOutMobile(),
                        AccountView()
                      ],
                      items: _navBarsItems(),
                      backgroundColor: Colors.white,
                      handleAndroidBackButtonPress: true,
                      stateManagement: true,
                      hideNavigationBarWhenKeyboardShows: true,
                    ),
                  )
                ],
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
      inactiveColorPrimary: Colors.black.withOpacity(0.5),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(FontAwesomeIcons.search),
      title: ("Search"),
      activeColorPrimary: accentColor,
      inactiveColorPrimary: Colors.black.withOpacity(0.5),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(FontAwesomeIcons.shoppingCart),
      title: ("Cart"),
      activeColorPrimary: accentColor,
      inactiveColorPrimary: Colors.black.withOpacity(0.5),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(FontAwesomeIcons.userAlt),
      title: ("Account"),
      activeColorPrimary: accentColor,
      inactiveColorPrimary: Colors.black.withOpacity(0.5),
    ),
  ];
}
