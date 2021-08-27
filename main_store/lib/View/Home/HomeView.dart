import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/ReviewModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCard.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBanners.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerView.dart';
import 'package:main_store/View/Home/HomeViewModel.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageView.dart';
import 'package:main_store/View/Widgets/Banners/banners.dart';
import 'package:main_store/View/Widgets/listingName.dart';
import 'package:main_store/View/Widgets/ProductCard/productListingCard.dart';
import 'package:main_store/View/Widgets/responsive.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: LandingPage(index: 0), tablet: Home(), desktop: Home());
  }
}

class HomeMobile extends StatelessWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        model.fetchTopSellingProducts();
        model.fetchOnSaleProducts();
        model.fetchNearbyProducts();
        model.getReviews();
      },
      builder: (context, model, child) => Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: SwipeBanner(
                  onMobile: true,
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              CategoryBanners(
                getBanner: (banners) => model.getBanner(banners),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Container(
                child: BrandsRow(
                  onMobile: true,
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Visibility(
                visible: !model.topSellingProducts.isEmpty,
                child: ProductListingRowMobile(
                  isLoading: model.isLoading,
                  listingName: 'Top Selling Products',
                  productDetails: model.topSellingProducts,
                ),
              ),
              ProductListingRowMobile(
                isLoading: model.isLoading,
                listingName: 'On Sale Products',
                productDetails: model.onSaleProducts,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Container(
                child: Text('What People Says about Us',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeHorizontal * 3)),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 2,
                ),
                width: double.infinity,
                height: SizeConfig.blockSizeVertical * 20,
                child: ListView.separated(
                  itemCount: model.reviewlist.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeHorizontal * 1),
                    child: ReviewsCard(
                        details: model.reviewlist[i], onMobile: true),
                  ),
                  separatorBuilder: (context, i) => SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 1,
                  ),
                ),
              ),
              NearbyProductsMobile(
                navegateToDetails: (e) => model.navigatetodetails(e),
                productDetails: model.nearbyProducts,
                isLoading: model.isNearbyloading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        Future.delayed(Duration(seconds: 2), () {
          model.fetchOnSaleProducts();
        });
        Future.delayed(Duration(seconds: 4), () {
          model.fetchTopSellingProducts();
        });
        model.fetchNearbyProducts();
        model.getReviews();
      },
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
              Visibility(
                visible: !model.topSellingProducts.isEmpty,
                child: ProductListingRow(
                  isLoading: model.isLoading,
                  listingName: 'Top Selling Products',
                  productDetails: model.topSellingProducts,
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              ProductListingRow(
                isLoading: model.isLoading,
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
                      cate: model.bannerlist.isNotEmpty
                          ? model.bannerlist[2].cate
                          : null,
                      bannerText: model.bannerlist.isNotEmpty
                          ? model.bannerlist[2].mainText
                          : null,
                      image: model.bannerlist.isNotEmpty
                          ? model.bannerlist[2].image
                          : null,
                    ),
                    MoreandMoreBanner(
                      cate: model.bannerlist.isNotEmpty
                          ? model.bannerlist[3].cate
                          : null,
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
                  isLoading: model.isNearbyloading,
                ),
              ),
              model.nearbyProducts.length == model.totalProducts
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
                        horizontal: SizeConfig.blockSizeHorizontal * 1),
                    child: ReviewsCard(details: model.reviewlist[i]),
                  ),
                  separatorBuilder: (context, i) => SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 1,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2),
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
  final bool? onMobile;
  final ReviewModel? details;
  const ReviewsCard({this.details, this.onMobile});

  @override
  Widget build(BuildContext context) {
    bool _onMobile = onMobile ?? false;
    return Container(
      height: _onMobile
          ? SizeConfig.blockSizeVertical * 20
          : SizeConfig.blockSizeVertical * 25,
      width: _onMobile
          ? SizeConfig.blockSizeHorizontal * 65
          : SizeConfig.blockSizeHorizontal * 35,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(1, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 2),
            child: Text(
              details!.message!,
              style: TextStyle(
                fontSize: _onMobile
                    ? SizeConfig.blockSizeHorizontal * 3
                    : SizeConfig.blockSizeHorizontal * 1.2,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Text(
            details!.user!,
            style: TextStyle(
              fontSize: _onMobile
                  ? SizeConfig.blockSizeHorizontal * 3
                  : SizeConfig.blockSizeHorizontal * 1,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          RatingStar(
            onMobile: _onMobile,
            rating: details!.rating,
          )
        ],
      ),
    );
  }
}

class RatingStar extends StatelessWidget {
  final int? rating;
  final bool? onMobile;
  RatingStar({this.rating, this.onMobile});

  @override
  Widget build(BuildContext context) {
    int _rating = rating ?? 1;
    return Container(
      width: onMobile! ? SizeConfig.blockSizeHorizontal * 60 : null,
      child: RatingBar.builder(
        ignoreGestures: true,
        initialRating: _rating.toDouble(),
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemSize: 20,
        itemPadding: EdgeInsets.symmetric(horizontal: 2),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: accentColor,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      ),
    );
  }
}

class NearbyProductsMobile extends StatelessWidget {
  List<ProductsModel>? productDetails;
  final Function(ProductsModel)? navegateToDetails;
  final bool? isLoading;
  NearbyProductsMobile({
    this.isLoading,
    this.navegateToDetails,
    this.productDetails,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isLoading = isLoading ?? false;
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
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: accentColor,
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeVertical * 3,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: productDetails!.length,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 2,
                          horizontal: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        child: ProductCardMobile(
                          isGrid: true,
                          onTap: () => navegateToDetails!(productDetails![i]),
                          details: productDetails![i],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class NearbyProducts extends StatelessWidget {
  List<ProductsModel>? productDetails;
  final Function(ProductsModel)? navegateToDetails;
  final bool? isLoading;

  NearbyProducts({this.productDetails, this.navegateToDetails, this.isLoading});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isLoading = isLoading ?? false;
    var width = MediaQuery.of(context).size.width;
    print(width);
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
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: accentColor,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeVertical * 3,
                  ),
                  child: GridView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (width >= 1366)
                          ? 5
                          : (width >= 1080)
                              ? 4
                              : (width >= 800)
                                  ? 3
                                  : 2,
                    ),
                    itemCount: productDetails!.length,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 2,
                          horizontal: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        child: ProductListingCards(
                          isGrid: true,
                          onTap: () => navegateToDetails!(productDetails![i]),
                          details: productDetails![i],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
