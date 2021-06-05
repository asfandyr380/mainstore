import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class ProductListingCards extends StatelessWidget {
  final String? productName;
  final String? productPrice;
  final String? salePrice;
  final String? categoryName;
  final bool? onSale;
  ProductListingCards(
      {this.categoryName,
      this.productName,
      this.productPrice,
      this.salePrice,
      this.onSale});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String _salePrice = salePrice ?? '';
    bool _onSale = onSale ?? false;
    return Container(
      child: Column(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 28,
            width: SizeConfig.blockSizeHorizontal * 15,
            decoration: BoxDecoration(color: footerColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 1,
                    left: SizeConfig.blockSizeHorizontal * 0.5,
                  ),
                  child: Icon(
                    FontAwesomeIcons.heart,
                    size: SizeConfig.blockSizeHorizontal * 1.5,
                  ),
                ),
                _onSale
                    ? Container(
                        alignment: Alignment.center,
                        width: SizeConfig.blockSizeHorizontal * 6,
                        height: SizeConfig.blockSizeVertical * 6,
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          'Sale!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeHorizontal * 1,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 0.7,
          ),
          // Product Name
          Container(
            child: Text(
              productName!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeHorizontal * 1,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 0.8,
          ),
          // Category Name
          Container(
            child: Text(
              categoryName!,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 0.7,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 0.8,
          ),
          // Price and Sale Price
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _onSale
                    ? Text(
                        '\$$_salePrice',
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 0.9,
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    : Container(),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 0.5,
                ),
                Text(
                  '\$$productPrice',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: SizeConfig.blockSizeHorizontal * 1,
                  ),
                ),
              ],
            ),
          ),
          // Add to Cart Button
          Container(
            height: SizeConfig.blockSizeVertical * 3,
            width: SizeConfig.blockSizeHorizontal * 7,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: accentColor,
                fixedSize: Size(
                  SizeConfig.blockSizeHorizontal * 1,
                  SizeConfig.blockSizeVertical * 1,
                ),
              ),
              onPressed: () {},
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeHorizontal * 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
