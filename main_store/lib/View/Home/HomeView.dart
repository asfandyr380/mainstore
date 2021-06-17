import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCard.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBanners.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/Home/HomeViewModel.dart';
import 'package:main_store/View/Widgets/CardGrid/CardGridView.dart';
import 'package:main_store/View/Widgets/banners.dart';
import 'package:main_store/View/Widgets/listingName.dart';
import 'package:stacked/stacked.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.getAvailableProduct().then((list) {
        model.fetchOnSaleProducts(list);
        model.fetchTopSellingProducts(list);
        model.fetchNearbyProducts(list);
      }),
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
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2,
                ),
                child: BrandsRow(),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              ProductListingRow(
                listingName: 'Top Selling Products',
                productDetails: model.topSellingProducts,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              ProductListingRow(
                productDetails: model.onSaleProducts,
                listingName: 'On Sale Products',
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2,
                    vertical: SizeConfig.blockSizeVertical * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MoreandMoreBanner(
                      bannerText: model.bannerlist.isNotEmpty
                          ? model.bannerlist[2].mainText
                          : null,
                      image: model.bannerlist.isNotEmpty
                          ? model.bannerlist[2].image
                          : null,
                    ),
                    MoreandMoreBanner(
                      bannerText: model.bannerlist.isNotEmpty
                          ? model.bannerlist[3].mainText
                          : null,
                      image: model.bannerlist.isNotEmpty
                          ? model.bannerlist[3].image
                          : null,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2),
                child: NearbyProducts(
                  productDetails: model.nearbyProducts,
                ),
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
  List<ProductsModel>? productDetails;

  NearbyProducts({this.productDetails});

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
            child: CardGridView(
              productDetails: productDetails,
            ),
          )
        ],
      ),
    );
  }
}

class Homemobile extends StatelessWidget {
  const Homemobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Text('HomePage'),
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
