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
      padding: EdgeInsets.only(bottom: 10),
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
                  child: Icon(FontAwesomeIcons.heart),
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
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          // Product Name
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              productName!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // Category Name
          Container(
            child: Text(
              categoryName!,
              style: TextStyle(fontSize: 12),
            ),
          ),
          // Price and Sale Price
          Container(
            child: Row(
              children: [
                _onSale
                    ? Text(
                        '\$$_salePrice',
                        style: TextStyle(
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    : Container(),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '\$$productPrice',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 12,
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
              style: ElevatedButton.styleFrom(primary: accentColor),
              onPressed: () {},
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
