import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCard.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBanners.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/Home/HomeViewModel.dart';
import 'package:main_store/View/Widgets/banners.dart';
import 'package:main_store/View/Widgets/listingName.dart';
import 'package:main_store/View/Widgets/productListingCard.dart';
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
                      bannerTextColor: Colors.white,
                      buttonColor: Colors.white,
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
                  navegateToDetails: (e) => model.navigatetodetails(e),
                  productDetails: model.nearbyProducts,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 4,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: accentColor,
                    fixedSize: Size(
                      SizeConfig.blockSizeHorizontal * 8,
                      SizeConfig.blockSizeVertical * 5,
                    ),
                  ),
                  child:
                      Text('Load More', style: TextStyle(color: Colors.white)),
                ),
              ),
              Divider(),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Download App',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/47q2YGt.png',
                            width: SizeConfig.blockSizeHorizontal * 20,
                            height: SizeConfig.blockSizeVertical * 18,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        Container(
                          child: Image.asset(
                            'assets/images/nkZP7fe.png',
                            width: SizeConfig.blockSizeHorizontal * 20,
                            height: SizeConfig.blockSizeVertical * 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              // Reviews
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2),
                width: double.infinity,
                height: SizeConfig.blockSizeVertical * 20,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => Container(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.blockSizeVertical * 2),
                    child: ReviewsCard(),
                  ),
                  separatorBuilder: (context, i) => SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 1,
                  ),
                  itemCount: 5,
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

class ReviewsCard extends StatelessWidget {
  const ReviewsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 25,
      width: SizeConfig.blockSizeHorizontal * 25,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 2),
              child: Text(dumyComment)),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Text('UserName'),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: RatingStar(),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class RatingStar extends StatelessWidget {
  final bool? isEnable;
  RatingStar({this.isEnable});

  @override
  Widget build(BuildContext context) {
    bool _isEnable = isEnable ?? true;
    return Container(
      height: 35,
      width: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _isEnable ? Colors.green : Colors.white,
      ),
      child: Icon(
        FontAwesomeIcons.star,
        size: 15,
        color: _isEnable ? Colors.white : Colors.black,
      ),
    );
  }
}

class NearbyProducts extends StatelessWidget {
  List<ProductsModel>? productDetails;
  final Function(ProductsModel)? navegateToDetails;
  NearbyProducts({this.productDetails, this.navegateToDetails});

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
            height: SizeConfig.blockSizeVertical * 160,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeVertical * 3,
            ),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: productDetails!.length,
              itemBuilder: (context, i) {
                return Container(
                  height: SizeConfig.blockSizeVertical * 10,
                  width: SizeConfig.blockSizeHorizontal * 5,
                  child: ProductListingCards(
                    onTap: () => navegateToDetails!(productDetails![i]),
                    productName: productDetails![i].name,
                    categoryName: productDetails![i].by,
                    productPrice: productDetails![i].productPrice,
                    image: productDetails![i].images![0],
                    salePrice: productDetails![i].salePrice,
                    onSale: productDetails![i].onSale,
                  ),
                );
              },
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
