import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRowViewModel.dart';
import 'package:main_store/View/Widgets/ProductListingArrow.dart';
import 'package:main_store/View/Widgets/productListingCard.dart';
import 'package:stacked/stacked.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ProductListingRow extends StatelessWidget {
  final String? listingName;
  final List<ProductsModel>? productDetails;
  final Function? onTap;
  ProductListingRow({this.listingName, this.productDetails, this.onTap});
  AutoScrollController _scrollController = AutoScrollController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          Container(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 3,
              horizontal: SizeConfig.blockSizeHorizontal * 3,
            ),
            height: SizeConfig.blockSizeVertical * 50,
            width: double.infinity,
            child: ListView.separated(
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
                    onTap: () => model.navigatetoDetailPage(productDetails![i]),
                    productName: productDetails![i].name,
                    productPrice: productDetails![i].productPrice,
                    onSale: productDetails![i].onSale,
                    salePrice: productDetails![i].salePrice,
                    categoryName: productDetails![i].by,
                    image: productDetails![i].images![0],
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
