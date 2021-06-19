import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class ProductListingCards extends StatefulWidget {
  final String? productName;
  final double? productPrice;
  final String? image;
  final double? salePrice;
  final String? categoryName;
  final bool? onSale;
  final Function? onTap;
  ProductListingCards(
      {this.categoryName,
      this.image,
      this.productName,
      this.productPrice,
      this.salePrice,
      this.onSale,
      this.onTap});

  @override
  _ProductListingCardsState createState() => _ProductListingCardsState();
}

class _ProductListingCardsState extends State<ProductListingCards> {
  bool hovering = false;

  final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);
  final hoverTransform = Matrix4.identity()..translate(0, -10, 0);

  void mouseEnter(bool hover) {
    setState(() {
      hovering = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _salePrice = widget.salePrice ?? 0;
    double _productPrice = widget.productPrice ?? 0;
    bool _onSale = widget.onSale ?? false;
    String _image = widget.image ?? placeholderProductPic;
    String _categoryName = widget.categoryName ?? '';
    return GestureDetector(
      onTap: () => widget.onTap!(),
      child: MouseRegion(
        onEnter: (e) => mouseEnter(true),
        onExit: (e) => mouseEnter(false),
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            curve: Curves.easeOut,
            transform: hovering ? hoverTransform : nonHoverTransform,
            padding: EdgeInsets.only(top: 30),
            height: SizeConfig.blockSizeVertical * 28,
            width: SizeConfig.blockSizeHorizontal * 15,
            decoration: hovering
                ? BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(1, 0),
                          blurRadius: 7,
                          spreadRadius: 1)
                    ],
                  )
                : BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Container(
                  height: SizeConfig.blockSizeVertical * 28,
                  width: SizeConfig.blockSizeHorizontal * 15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_image),
                    ),
                  ),
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
                    widget.productName!,
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
                    _categoryName,
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
                              '£$_salePrice',
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
                        '£$_productPrice',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
