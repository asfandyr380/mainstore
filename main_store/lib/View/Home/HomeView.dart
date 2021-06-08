import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCard.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBanners.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/Home/HomeViewModel.dart';
import 'package:main_store/View/Widgets/CardGridView.dart';
import 'package:main_store/View/Widgets/banners.dart';
import 'package:main_store/View/Widgets/listingName.dart';
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
                child: Header(
                  onHomepage: true,
                ),
              ),
              // Main Page Products Listing
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2),
                child: HomePageHeader(),
              ),
              Container(
                child: CategoryBanners(
                  getBanner: (banners) => model.getBanner(banners),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: BrandsRow(),
              ),
              ProductListingRow(
                listingName: 'Top Selling Products',
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              ProductListingRow(
                listingName: 'On Sale Products',
                onSale: true,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2,
                    vertical: SizeConfig.blockSizeVertical * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MoreandMoreBanner(
                      bannerText: model.banner.isNotEmpty
                          ? model.banner[2].mainText
                          : '',
                      image:
                          model.banner.isNotEmpty ? model.banner[2].image : '',
                    ),
                    MoreandMoreBanner(
                      bannerText: model.banner.isNotEmpty
                          ? model.banner[3].mainText
                          : '',
                      image:
                          model.banner.isNotEmpty ? model.banner[3].image : '',
                    ),
                  ],
                ),
              ),
              Container(
                child: NearbyProducts(),
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

class NearbyProducts extends StatelessWidget {
  const NearbyProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 2,
                bottom: SizeConfig.blockSizeVertical * 2),
            child: ListingName(
              listingName: 'Products For You',
            ),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 150,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeVertical * 3,
            ),
            child: CardGridView(),
          )
        ],
      ),
    );
  }
}
