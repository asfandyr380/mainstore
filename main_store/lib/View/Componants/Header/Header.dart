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
  final bool? isSignIn;
  final bool? onHomepage;
  Header({this.isSignIn, this.onHomepage});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isSignIn = isSignIn ?? false;
    bool _onHomePage = onHomepage ?? false;
    return ViewModelBuilder<HeaderViewModel>.reactive(
      viewModelBuilder: () => HeaderViewModel(),
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
                      left: SizeConfig.blockSizeHorizontal * 33),
                  child: Text('Free Shipping Over 12\$ Order'),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 9,
                height: SizeConfig.blockSizeVertical * 13,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
              HeaderPageNavigationButton(),
              Container(
                padding:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2),
                child: CartFavandSignupLoginRow(
                  isSignIn: _isSignIn,
                  onTap: () => model.navigateToSignInLogInPage(_isSignIn),
                ),
              ),
            ],
          ),
          // Second Bar
          _onHomePage
              ? Container(
                  padding: EdgeInsets.only(
                      bottom: 10, left: SizeConfig.blockSizeHorizontal * 25),
                  child: SearchBarRow(),
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
              padding: EdgeInsets.only(bottom: 10),
              child: SearchBarRow(),
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
  final bool? isSignIn;
  final Function onTap;
  CartFavandSignupLoginRow({this.isSignIn, required this.onTap});
  @override
  Widget build(BuildContext context) {
    bool _isSignIn = isSignIn ?? false;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => onTap(),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: _isSignIn ? Text('LOGIN') : Text('SIGN UP'),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.heart),
                ],
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.shoppingCart),
                ],
              ),
            ),
          ),
        ],
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
            child: Text('Home', style: menuTextStyle),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            child: Text(
              'About Us',
              style: menuTextStyle,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            child: Text(
              'Contact Us',
              style: menuTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
