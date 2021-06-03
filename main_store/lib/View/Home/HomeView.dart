import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCard.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBanners.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/Componants/SideNav/SideNavView.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerView.dart';
import 'package:main_store/View/Home/HomeViewModel.dart';
import 'package:main_store/View/Widgets/SearchBarRow.dart';
import 'package:stacked/stacked.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Page Header
              Container(
                child: Header(),
              ),
              // Main Page Products Listing
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2),
                child: HomePageHeader(),
              ),
              Container(
                child: CategoryBanners(),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 5; i++) BrandsCard(),
                  ],
                ),
              ),
              ProductListingRow(
                listingName: 'Top Selling Products',
              ),
              ProductListingRow(
                listingName: 'On Sale Products',
                onSale: true,
              ),
              // Page Footer
              Container(
                child: Footer(),
              ),
            ],
          ),
        ),
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
