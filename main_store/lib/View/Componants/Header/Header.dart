import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Header/HeaderViewModel.dart';
import 'package:main_store/View/Componants/SideNav/SideNavView.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerView.dart';
import 'package:main_store/View/Widgets/SearchBarRow.dart';
import 'package:stacked/stacked.dart';
import 'package:main_store/Extention/hover_extention.dart';

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
      onModelReady: (model) => model.getUser(),
      builder: (context, model, child) => Column(
        children: [
          // Social Icons Bar
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0.5),
                  color: Colors.grey,
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: SizeConfig.blockSizeHorizontal * 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(FontAwesomeIcons.facebookF, size: 15),
                      Icon(FontAwesomeIcons.twitter, size: 15),
                      Icon(FontAwesomeIcons.instagram, size: 15),
                      Icon(FontAwesomeIcons.pinterestP, size: 15),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 33,
                  ),
                  child: Text('Free Shipping Over 12\$ Order'),
                ),
              ],
            ),
          ),
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
                      : HeaderPageNavigationButton(),
                ),
                Container(
                  child: CartFavandSignupLoginRow(
                      onCartPressed: () => model.navigateToCart(),
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
                      child: HeaderPageNavigationButton(),
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
  CartFavandSignupLoginRow({
    this.isSignInPage,
    required this.onTap,
    this.userLogedIn,
    this.onCartPressed,
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
                  Icon(
                    FontAwesomeIcons.heart,
                    size: SizeConfig.blockSizeHorizontal * 2,
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
                  IndexIndicator(),
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
  const IndexIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.blockSizeVertical * 2.4,
      width: SizeConfig.blockSizeHorizontal * 2.4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accentColor,
      ),
      child: Text(
        '0',
        style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 0.6,
          color: Colors.white,
        ),
      ),
    );
  }
}

class HeaderPageNavigationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            child: Text(
              'Home',
              style: menuTextStyle.copyWith(
                fontSize: SizeConfig.blockSizeHorizontal * 1.2,
              ),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 1.3,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            child: Text(
              'About Us',
              style: menuTextStyle.copyWith(
                fontSize: SizeConfig.blockSizeHorizontal * 1.2,
              ),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 1.3,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            child: Text(
              'Contact Us',
              style: menuTextStyle.copyWith(
                fontSize: SizeConfig.blockSizeHorizontal * 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
