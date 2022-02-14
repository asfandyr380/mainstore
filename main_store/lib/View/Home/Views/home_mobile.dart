import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/BrandsCard/BrandsCard.dart';
import 'package:main_store/View/Componants/CategoryBanners/CategoryBanners.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerView.dart';
import 'package:main_store/View/Home/HomeViewModel.dart';
import 'package:stacked/stacked.dart';
import '../home_view.dart';

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
              CategoryBanners(type: CategoryBannerType.mobile),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Container(
                child: BrandsRow(type: BrandCardViewType.mobile),
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
                        fontSize: SizeConfig.blockSizeHorizontal * 5)),
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
