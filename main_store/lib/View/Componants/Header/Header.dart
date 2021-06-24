import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Header/HeaderViewModel.dart';
import 'package:main_store/View/Componants/SideNav/SideNavView.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerView.dart';
import 'package:main_store/View/Widgets/SearchBarRow.dart';
import 'package:stacked/stacked.dart';

class Header extends StatelessWidget {
  final bool? isSignInPage;
  final bool? onHomepage;
  Header({this.isSignInPage, this.onHomepage});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isSignInPage = isSignInPage ?? false;
    bool _onHomePage = onHomepage ?? false;
    return ViewModelBuilder<HeaderViewModel>.reactive(
      viewModelBuilder: () => HeaderViewModel(),
      onModelReady: (model) {
        model.getUser();
        model.getCount();
      },
      builder: (context, model, child) => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 2,
              horizontal: SizeConfig.blockSizeHorizontal * 3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    height: SizeConfig.blockSizeVertical * 12,
                    width: SizeConfig.blockSizeHorizontal * 12,
                  ),
                ),
                Container(
                  child: !_onHomePage
                      ? SearchBarRow()
                      : HeaderPageNavigationButton(
                          goHome: () => model.navigateToHome(),
                          goContact: () => model.navigateToContact(),
                          goAbout: () => model.navigateToAbout(),
                        ),
                ),
                Container(
                  child: CartFavandSignupLoginRow(
                      cartCount: model.cartCount,
                      onCartPressed: () => model.navigateToCart(),
                      goToWishList: () => model.navigateToWishlist(),
                      userLogedIn: model.userLogedIn,
                      isSignInPage: _isSignInPage,
                      onTap: () {
                        if (model.userLogedIn) {
                          model.signoutUser();
                        } else {
                          model.navigateToSignInLogInPage(_isSignInPage);
                        }
                      }),
                ),
              ],
            ),
          ),
          // Second Bar
          !_onHomePage
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: HeaderPageNavigationButton(
                        goHome: () => model.navigateToHome(),
                        goContact: () => model.navigateToContact(),
                        goAbout: () => model.navigateToAbout(),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class HomePageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: SideNavMenu(),
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                right: SizeConfig.blockSizeHorizontal * 20,
              ),
              child: SearchBarRow(),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              child: SwipeBanner(),
            ),
          ],
        )
      ],
    );
  }
}

class CartFavandSignupLoginRow extends StatelessWidget {
  final bool? isSignInPage;
  final Function onTap;
  final bool? userLogedIn;
  final Function? onCartPressed;
  final int? cartCount;
  final Function? goToWishList;
  CartFavandSignupLoginRow({
    this.isSignInPage,
    required this.onTap,
    this.userLogedIn,
    this.onCartPressed,
    this.cartCount,
    this.goToWishList,
  });
  @override
  Widget build(BuildContext context) {
    bool _isSignInPage = isSignInPage ?? false;
    bool _userLogedIn = userLogedIn ?? false;
    SizeConfig().init(context);
    return Container(
      child: Row(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onTap(),
              child: Container(
                child: !_userLogedIn
                    ? Text(
                        _isSignInPage ? 'SIGN UP' : 'LOGIN',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 1),
                      )
                    : Text(
                        'SIGN OUT',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 0.8,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => goToWishList!(),
                    icon: Icon(
                      FontAwesomeIcons.heart,
                      size: SizeConfig.blockSizeHorizontal * 2,
                    ),
                  ),
                  IndexIndicator(),
                ],
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 0.8,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => onCartPressed!(),
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      size: SizeConfig.blockSizeHorizontal * 2,
                    ),
                  ),
                  IndexIndicator(
                    count: cartCount,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IndexIndicator extends StatelessWidget {
  final int? count;
  IndexIndicator({this.count});

  @override
  Widget build(BuildContext context) {
    int _count = count ?? 0;
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.blockSizeVertical * 2.4,
      width: SizeConfig.blockSizeHorizontal * 2.4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accentColor,
      ),
      child: Text(
        '$_count',
        style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 0.6,
          color: Colors.white,
        ),
      ),
    );
  }
}

class HeaderPageNavigationButton extends StatefulWidget {
  final Function goHome;
  final Function goContact;
  final Function goAbout;
  HeaderPageNavigationButton(
      {required this.goAbout, required this.goContact, required this.goHome});

  @override
  _HeaderPageNavigationButtonState createState() =>
      _HeaderPageNavigationButtonState();
}

class _HeaderPageNavigationButtonState
    extends State<HeaderPageNavigationButton> {
  bool onHover = false;
  bool onHover1 = false;
  bool onHover2 = false;

  mouseEnter(bool state) {
    setState(() {
      onHover = state;
    });
  }

  mouseEnter1(bool state) {
    setState(() {
      onHover1 = state;
    });
  }

  mouseEnter2(bool state) {
    setState(() {
      onHover2 = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HeaderPageNavigation(
          label: 'Home',
          mouseEnter: (e) => mouseEnter(e),
          onHover: onHover,
          onTap: () => widget.goHome(),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 1.3,
        ),
        HeaderPageNavigation(
          label: 'Contact Us',
          mouseEnter: (e) => mouseEnter1(e),
          onHover: onHover1,
          onTap: () => widget.goContact(),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 1.3,
        ),
        HeaderPageNavigation(
          label: 'About Us',
          mouseEnter: (e) => mouseEnter2(e),
          onHover: onHover2,
          onTap: () => widget.goAbout(),
        ),
      ],
    );
  }
}

class HeaderPageNavigation extends StatelessWidget {
  final Function(bool)? mouseEnter;
  final bool? onHover;
  final Function onTap;
  final String? label;
  const HeaderPageNavigation(
      {this.mouseEnter, this.onHover, required this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    bool _onHover = onHover ?? false;
    return GestureDetector(
      onTap: () => onTap(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => mouseEnter!(true),
        onExit: (e) => mouseEnter!(false),
        child: Container(
          child: Text(
            '$label',
            style: menuTextStyle.copyWith(
              color: _onHover ? accentColor : Colors.black,
              fontSize: SizeConfig.blockSizeHorizontal * 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
