import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCard.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBanners.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerView.dart';
import 'package:main_store/View/Home/HomeViewModel.dart';
import 'package:main_store/View/Widgets/ProductListingArrow.dart';
import 'package:stacked/stacked.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Header(
                  onTap: () {},
                ),
              ),
              Column(
                children: [
                  SwipeBanner(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: CategoryBanners(
                          bannerText: 'Fruits & \nDried Fruits',
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: CategoryBanners(
                          bannerText: 'Grocery \nItem',
                          isMiddle: true,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: CategoryBannersSmall(
                              bannerText: 'Fresh Bread',
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: CategoryBannersSmall(
                              bannerText: 'Fish & SeaFood',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
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
