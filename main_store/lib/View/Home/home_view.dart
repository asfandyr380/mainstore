import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/ReviewModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageView.dart';
import 'package:main_store/View/Widgets/listingName.dart';
import 'package:main_store/View/Widgets/ProductCard/productListingCard.dart';
import 'package:main_store/View/Widgets/responsive.dart';
import 'Views/home_desktop.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: LandingPage(index: 0), tablet: Home(), desktop: Home());
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
      padding: EdgeInsets.all(5),
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
            width: _onMobile
                ? SizeConfig.blockSizeHorizontal * 65
                : SizeConfig.blockSizeHorizontal * 30,
            child: Text(
              details!.message!,
              textAlign: TextAlign.center,
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
