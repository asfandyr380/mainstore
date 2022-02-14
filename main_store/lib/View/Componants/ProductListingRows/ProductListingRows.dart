import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRowViewModel.dart';
import 'package:main_store/View/Widgets/ProductListingArrow.dart';
import 'package:main_store/View/Widgets/ProductCard/productListingCard.dart';
import 'package:stacked/stacked.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ProductListingRowMobile extends StatelessWidget {
  final String? listingName;
  final List<ProductsModel>? productDetails;
  final Function? onTap;
  final bool? isLoading;
  ProductListingRowMobile({
    this.listingName,
    this.productDetails,
    this.onTap,
    this.isLoading,
  });
  AutoScrollController _scrollController = AutoScrollController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isLoading = isLoading ?? false;
    return ViewModelBuilder<ProductListingRowViewModel>.reactive(
      viewModelBuilder: () => ProductListingRowViewModel(),
      builder: (context, model, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listingName!,
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: SizeConfig.blockSizeVertical * 0.5,
                      width: SizeConfig.blockSizeHorizontal * 15,
                      color: accentColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: accentColor,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 3,
                    horizontal: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  width: double.infinity,
                  height: SizeConfig.blockSizeVertical * 33,
                  child: ListView.separated(
                    shrinkWrap: true,
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: productDetails!.length,
                    separatorBuilder: (context, i) {
                      return SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      );
                    },
                    itemBuilder: (context, i) {
                      return AutoScrollTag(
                        key: ValueKey(i),
                        controller: _scrollController,
                        index: i,
                        child: ProductCardMobile(
                          onTap: () => model.navigatetoDetailPage(
                            productDetails![i],
                          ),
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

class ProductListingRow extends StatelessWidget {
  final String? listingName;
  final List<ProductsModel>? productDetails;
  final Function? onTap;
  final bool? isLoading;
  final bool? onMobile;
  ProductListingRow(
      {this.listingName,
      this.productDetails,
      this.onTap,
      this.isLoading,
      this.onMobile});
  AutoScrollController _scrollController = AutoScrollController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isLoading = isLoading ?? false;
    return ViewModelBuilder<ProductListingRowViewModel>.reactive(
      viewModelBuilder: () => ProductListingRowViewModel(),
      builder: (context, model, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listingName!,
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: SizeConfig.blockSizeVertical * 0.5,
                      width: SizeConfig.blockSizeHorizontal * 5,
                      color: accentColor,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 4),
                child: Row(
                  children: [
                    ProductListNextArrowButton(
                      onTap: () => model.scrollBack(
                          _scrollController, productDetails!.length),
                      icon: Icon(FontAwesomeIcons.arrowLeft),
                    ),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 0.5),
                    ProductListNextArrowButton(
                      onTap: () => productDetails!.length < 5
                          ? null
                          : model.scrollNext(
                              _scrollController, productDetails!.length),
                      icon: Icon(FontAwesomeIcons.arrowRight),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: accentColor,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 3,
                    horizontal: SizeConfig.blockSizeHorizontal * 3,
                  ),
                  width: double.infinity,
                  height: SizeConfig.blockSizeVertical * 45,
                  child: ListView.separated(
                    shrinkWrap: true,
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: productDetails!.length,
                    separatorBuilder: (context, i) {
                      return SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      );
                    },
                    itemBuilder: (context, i) {
                      return AutoScrollTag(
                        key: ValueKey(i),
                        controller: _scrollController,
                        index: i,
                        child: ProductListingCards(
                          onTap: () =>
                              model.navigatetoDetailPage(productDetails![i]),
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
