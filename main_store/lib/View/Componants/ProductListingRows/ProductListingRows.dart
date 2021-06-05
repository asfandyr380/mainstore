import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Widgets/ProductListingArrow.dart';
import 'package:main_store/View/Widgets/productListingCard.dart';

class ProductListingRow extends StatelessWidget {
  final String? listingName;
  final bool? onSale;
  final List<Object>? productDetails;
  ProductListingRow({this.listingName, this.productDetails, this.onSale});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Object> _productDetails = productDetails ?? [];
    bool _onSale = onSale ?? false;
    return Column(
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
                      icon: Icon(FontAwesomeIcons.arrowLeft)),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 0.5),
                  ProductListNextArrowButton(
                      icon: Icon(FontAwesomeIcons.arrowRight)),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProductListingCards(
                productName: 'Name',
                productPrice: '150',
                categoryName: 'CatName',
                salePrice: '120',
                onSale: _onSale,
              ),
              ProductListingCards(
                productName: 'Name1',
                productPrice: '150',
                categoryName: 'CatName',
                salePrice: '120',
                onSale: _onSale,
              ),
              ProductListingCards(
                productName: 'Name2',
                categoryName: 'CatName',
                productPrice: '150',
                salePrice: '120',
                onSale: _onSale,
              ),
              ProductListingCards(
                productName: 'Nam3',
                categoryName: 'CatName',
                productPrice: '150',
                salePrice: '120',
                onSale: _onSale,
              ),
              ProductListingCards(
                productName: 'Nam4',
                categoryName: 'CatName',
                productPrice: '150',
                salePrice: '120',
                onSale: _onSale,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
