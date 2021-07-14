import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Widgets/ProductCard/CardViewModel.dart';
import 'package:stacked/stacked.dart';

class ProductCardMobile extends StatefulWidget {
  final ProductsModel? details;
  ProductCardMobile({this.details});

  @override
  _ProductCardMobileState createState() => _ProductCardMobileState();
}

class _ProductCardMobileState extends State<ProductCardMobile> {
  @override
  Widget build(BuildContext context) {
    String _image = widget.details!.images![0];
    String _categoryName = widget.details!.category![0];
    String _productName = widget.details!.name ?? '';
    int _onSale = widget.details!.onSale ?? 0;
    double _salePrice = widget.details!.salePrice ?? 0;
    double _price = widget.details!.productPrice ?? 0;
    int _productId = widget.details!.productId;
    return ViewModelBuilder<CardViewModel>.reactive(
      viewModelBuilder: () => CardViewModel(),
      onModelReady: (model) => model.onWishlist = widget.details!.onWishlist!,
      builder: (ctx, model, child) => GestureDetector(
        // onTap: () => widget.onTap!(),
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 18,
              width: SizeConfig.blockSizeHorizontal * 35,
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
                      top: SizeConfig.blockSizeVertical * 0.5,
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (model.onWishlist) {
                          model.removeFromlist(_productId);
                          setState(() {
                            if (model.onWishlist)
                              model.onWishlist = false;
                            else
                              model.onWishlist = true;
                          });
                        } else {
                          model.addtoWishlist(_productId);
                          setState(() {
                            if (model.onWishlist)
                              model.onWishlist = false;
                            else
                              model.onWishlist = true;
                          });
                        }
                      },
                      icon: Icon(
                        model.onWishlist
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        size: SizeConfig.blockSizeHorizontal * 2.5,
                      ),
                    ),
                  ),
                  _onSale == 1
                      ? Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 9, right: 10),
                          width: SizeConfig.blockSizeHorizontal * 5,
                          height: SizeConfig.blockSizeVertical * 5,
                          decoration: BoxDecoration(
                            color: accentColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            'Sale!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeHorizontal * 1.5,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 0.8,
            ),
            // Product Name
            Container(
              child: Text(
                _productName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 3,
                ),
              ),
            ),
            // Category Name
            Container(
              child: Text(
                _categoryName,
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 2,
                ),
              ),
            ),
            // Price and Sale Price
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _onSale == 1
                      ? Text(
                          '£$_salePrice',
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 1.5,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                      : Container(),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                  ),
                  Text(
                    '£$_price',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: SizeConfig.blockSizeHorizontal * 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListingCards extends StatefulWidget {
  final ProductsModel? details;
  final Function? onTap;
  final bool? isGrid;
  ProductListingCards({
    this.details,
    this.onTap,
    this.isGrid,
  });

  @override
  _ProductListingCardsState createState() => _ProductListingCardsState();
}

class _ProductListingCardsState extends State<ProductListingCards> {
  bool hovering = false;
  bool onWishlist = false;

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
    double _salePrice = widget.details!.salePrice ?? 0;
    double _productPrice = widget.details!.productPrice ?? 0;
    int _prodcutId = widget.details!.productId;
    int _onSale = widget.details!.onSale ?? 0;
    String _image = widget.details!.images![0];
    String _categoryName = widget.details!.category![0];
    bool _isGrid = widget.isGrid ?? false;
    String _productName = widget.details!.name ?? '';
    return ViewModelBuilder<CardViewModel>.reactive(
      viewModelBuilder: () => CardViewModel(),
      onModelReady: (model) => model.onWishlist = widget.details!.onWishlist!,
      builder: (context, model, child) => GestureDetector(
        onTap: () => widget.onTap!(),
        child: MouseRegion(
          onEnter: (e) => mouseEnter(true),
          onExit: (e) => mouseEnter(false),
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            curve: Curves.easeOut,
            transform: hovering ? hoverTransform : nonHoverTransform,
            width: SizeConfig.blockSizeHorizontal * 15,
            decoration: hovering
                ? BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.10),
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
                      fit: _isGrid ? BoxFit.contain : BoxFit.cover,
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
                        child: IconButton(
                          onPressed: () {
                            if (model.onWishlist) {
                              model.removeFromlist(_prodcutId);
                              setState(() {
                                if (model.onWishlist)
                                  model.onWishlist = false;
                                else
                                  model.onWishlist = true;
                              });
                            } else {
                              model.addtoWishlist(_prodcutId);
                              setState(() {
                                if (model.onWishlist)
                                  model.onWishlist = false;
                                else
                                  model.onWishlist = true;
                              });
                            }
                          },
                          icon: Icon(
                            model.onWishlist
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            size: SizeConfig.blockSizeHorizontal * 1.5,
                          ),
                        ),
                      ),
                      _onSale == 1
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
                  height: _isGrid
                      ? SizeConfig.blockSizeVertical * 0.2
                      : SizeConfig.blockSizeVertical * 0.8,
                ),
                // Product Name
                Container(
                  child: Text(
                    _productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeHorizontal * 1,
                    ),
                  ),
                ),
                // Category Name
                Container(
                  child: Text(
                    _categoryName,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 0.5,
                    ),
                  ),
                ),
                // Price and Sale Price
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _onSale == 1
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
