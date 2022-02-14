import 'package:flutter/material.dart';
import 'package:main_store/Componants/Header/header_view.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCard.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBanners.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/Home/HomeViewModel.dart';
import 'package:main_store/View/Widgets/Banners/banners.dart';
import 'package:stacked/stacked.dart';
import '../home_view.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.init(context),
      onDispose: (model) => model.disposeStuff(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: [
                    // Page Header
                    Header(type: HeaderViewType.basic),

                    SizedBox(height: context.percentHeight * 3),

                    // Home Page Products Listing Header
                    Header(type: HeaderViewType.withBanners),

                    CategoryBanners(type: CategoryBannerType.desktop),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                      ),
                      child: BrandsRow(type: BrandCardViewType.desktop),
                    ),

                    Visibility(
                      visible: !model.topSellingProducts.isEmpty,
                      child: ProductListingRow(
                        isLoading: model.isLoading,
                        listingName: 'Top Selling Products',
                        productDetails: model.topSellingProducts,
                      ),
                    ),

                    SizedBox(height: SizeConfig.blockSizeVertical * 2),

                    Visibility(
                      visible: !model.onSaleProducts.isEmpty,
                      child: ProductListingRow(
                        isLoading: model.isLoading,
                        productDetails: model.onSaleProducts,
                        listingName: 'On Sale Products',
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BannerView(
                            type: BannersViewType.long,
                            cate: model.bannerlist[2].cate,
                            bannerText: model.bannerlist[2].mainText,
                            image: model.bannerlist[2].image,
                          ),
                          BannerView(
                            type: BannersViewType.long,
                            cate: model.bannerlist[3].cate,
                            bannerTextColor: Colors.white,
                            buttonColor: Colors.white,
                            bannerText: model.bannerlist[3].mainText,
                            image: model.bannerlist[3].image,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 2),
                      child: NearbyProducts(
                        navegateToDetails: (e) => model.navigatetodetails(e),
                        productDetails: model.nearbyProducts,
                        isLoading: model.isNearbyloading,
                      ),
                    ),
                    model.nearbyProducts.length >= model.totalProducts
                        ? Container()
                        : Container(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 4,
                            ),
                            child: ElevatedButton(
                              onPressed: () => model.loadMore(),
                              style: ElevatedButton.styleFrom(
                                primary: accentColor,
                                fixedSize: Size(
                                  SizeConfig.blockSizeHorizontal * 8,
                                  SizeConfig.blockSizeVertical * 5,
                                ),
                              ),
                              child: model.isButtonLoading
                                  ? Container(
                                      height: 12,
                                      width: 12,
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    )
                                  : Text('Load More',
                                      style: TextStyle(color: Colors.white)),
                            ),
                          ),
                    Divider(),
                    // Reviews
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Container(
                      child: Text('What People Says about Us',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeHorizontal * 2)),
                    ),

                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      width: double.infinity,
                      height: SizeConfig.blockSizeVertical * 27,
                      child: ListView.separated(
                        itemCount: model.reviewlist.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) => Container(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 2,
                          ),
                          child: ReviewsCard(details: model.reviewlist[i]),
                        ),
                        separatorBuilder: (context, i) => SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Download Our App',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 2),
                              ),
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2),
                              Image.asset(
                                'assets/images/nkZP7fe.png',
                                fit: BoxFit.contain,
                                height: SizeConfig.blockSizeVertical * 20,
                                width: SizeConfig.blockSizeHorizontal * 20,
                              ),
                              Image.asset(
                                'assets/images/47q2YGt.png',
                                height: SizeConfig.blockSizeVertical * 20,
                                width: SizeConfig.blockSizeHorizontal * 20,
                              ),
                            ],
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 30,
                            width: SizeConfig.blockSizeHorizontal * 0.2,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 10),
                              child: Image.asset(
                                'assets/images/Iphone.png',
                                fit: BoxFit.cover,
                                height: SizeConfig.blockSizeVertical * 70,
                                width: SizeConfig.blockSizeHorizontal * 30,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
