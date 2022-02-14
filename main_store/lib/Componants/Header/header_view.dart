import 'package:flutter/material.dart';
import 'package:main_store/Componants/Header/header_viewmodel.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/SideNav/SideNavView.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerView.dart';
import 'package:main_store/View/Widgets/Header_Widgets/cart_login_fav.dart';
import 'package:main_store/View/Widgets/Header_Widgets/navigation_buttons.dart';
import 'package:main_store/View/Widgets/SearchWidget/SearchBarRow.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

enum HeaderViewType { basic, searchable, withBanners }

class Header extends StatelessWidget {
  final HeaderViewType type;
  Header({required this.type});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<HeaderViewModel>.reactive(
      viewModelBuilder: () => HeaderViewModel(),
      onModelReady: (model) => model.init(),
      onDispose: (model) => model.disposeStuff(),
      builder: (context, model, child) {
        switch (type) {
          case HeaderViewType.basic:
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Store Logo
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      height: context.percentHeight * 12,
                      width: context.percentWidth * 12,
                    ),

                    // Navigation Buttons
                    NavigationButtonButton(
                      goHome: () => model.navigateToHome(),
                      goContact: () => model.navigateToContact(),
                      goAbout: () => model.navigateToAbout(),
                    ),

                    // Cart, Login Wishlist Button
                    CartFavandSignupLoginRow(
                      wishCount: model.wishlistCount,
                      cartCount: model.cartCount,
                      onCartPressed: () => model.navigateToCart(),
                      goToWishList: () => model.navigateToWishlist(),
                      userLogedIn: model.userLogedIn,
                      onTap: (val) {
                        if (model.userLogedIn) {
                          model.selectOption(val);
                        } else {
                          model.navigateToLogInPage();
                        }
                      },
                    ),
                  ],
                ),
              ],
            );

          case HeaderViewType.searchable:
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Store Logo
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      height: context.percentHeight * 12,
                      width: context.percentWidth * 12,
                    ),

                    // Search Bar
                    SearchBarRow(),

                    // Cart, Login Wishlist Button
                    CartFavandSignupLoginRow(
                      wishCount: model.wishlistCount,
                      cartCount: model.cartCount,
                      onCartPressed: () => model.navigateToCart(),
                      goToWishList: () => model.navigateToWishlist(),
                      userLogedIn: model.userLogedIn,
                      onTap: (val) {
                        if (model.userLogedIn) {
                          model.selectOption(val);
                        } else {
                          model.navigateToLogInPage();
                        }
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NavigationButtonButton(
                        goHome: () => model.navigateToHome(),
                        goContact: () => model.navigateToContact(),
                        goAbout: () => model.navigateToAbout(),
                      ),
                    ],
                  ),
                ),
              ],
            );

          case HeaderViewType.withBanners:
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SideNavMenu(),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 20,
                      ),
                      child: SearchBarRow(),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    SwipeBanner(),
                  ],
                )
              ],
            );
        }
      },
    );
  }
}
