import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Widgets/snapshotCrousel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/ProductDetail/productDetailViewMode.dart';
import 'package:stacked/stacked.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

class ProductDetailView extends StatelessWidget {
  final ProductsModel productDetails;
  ProductDetailView({required this.productDetails});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      onModelReady: (model) =>
          model.fetchRelatedProduct(productDetails.category!),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                  )
                ]),
                child: Header(),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 5,
                  left: SizeConfig.blockSizeHorizontal * 5,
                ),
                child: BreadCrumb(
                  items: [
                    BreadCrumbItem(
                      content: Text('General Grocery'),
                      color: accentColor,
                    ),
                    BreadCrumbItem(
                      content: Text('Category'),
                      color: accentColor,
                    ),
                    BreadCrumbItem(
                      content: Text('Product Name'),
                      color: accentColor,
                    ),
                  ],
                  divider: Icon(Icons.chevron_right),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Product Image Carousal
                    Container(
                      child: ProductImageCarousel(
                        images: productDetails.images,
                      ),
                    ),
                    // Product Detials
                    Container(
                      child: ProductDetails(
                        name: productDetails.name,
                        by: productDetails.by,
                        price: productDetails.productPrice,
                        description: productDetails.description,
                        salePrice: productDetails.salePrice,
                        onSale: productDetails.onSale,
                        addorplus: (val) => model.addOrMiuns(val),
                        quantity: model.quantity,
                        addtoCart: () {
                          print('addtoCart');
                          model
                              .addtoCart(
                            productDetails.reference,
                            productDetails.by,
                            0,
                          )
                              .then((val) {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                message: 'Product Added to Cart',
                              ),
                              displayDuration: Duration(milliseconds: 150),
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Reviews and Description Panal
              DescriptionReviewsPanalHeader(),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.blockSizeVertical * 5,
                ),
                width: SizeConfig.blockSizeHorizontal * 90,
                height: SizeConfig.blockSizeVertical * 30,
                child: Text(
                  "${productDetails.description}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 1,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.blockSizeVertical * 3,
                ),
                child: ProductListingRow(
                  listingName: 'Related Products',
                  productDetails: model.relatedlist,
                ),
              ),
              // Footer
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

class DescriptionReviewsPanalHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 4,
      width: SizeConfig.blockSizeHorizontal * 90,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 1,
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 1,
        ),
        child: Row(
          children: [
            Text(
              'Description |',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 1.2,
              ),
            ),
            Text(
              ' Review',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductImageCarousel extends StatelessWidget {
  final List<String>? images;
  ProductImageCarousel({this.images});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 70,
      width: SizeConfig.blockSizeHorizontal * 30,
      child: SnapShotCarousel.snapShotCarousel(
          [for (var image in images!) Image.network(image)],
          featureImageHeight: SizeConfig.blockSizeVertical * 50,
          placeholderImageHeight: SizeConfig.blockSizeVertical * 10),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final String? name;
  final String? by;
  final double? price;
  final String? description;
  final double? salePrice;
  final bool? onSale;
  final Function addtoCart;
  final Function(bool)? addorplus;
  final int? quantity;
  ProductDetails({
    this.salePrice,
    this.by,
    this.description,
    this.name,
    this.price,
    this.onSale,
    required this.addtoCart,
    this.addorplus,
    this.quantity,
  });
  @override
  Widget build(BuildContext context) {
    String _name = name ?? '';
    String _by = by ?? '';
    double _price = price ?? 0;
    String _decsription = description ?? dumpyProductDetail;
    double _salePrice = salePrice ?? 0;
    bool _onSale = onSale ?? false;
    int _quantity = quantity ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            _name,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: _name.length >= 20
                  ? SizeConfig.blockSizeHorizontal * 2
                  : SizeConfig.blockSizeHorizontal * 4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 0.7,
        ),
        Container(
          child: Row(
            children: [
              Text(
                'By:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeHorizontal * 1),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 0.3,
              ),
              Text(
                _by,
                style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeHorizontal * 1),
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Container(
          child: _onSale
              ? Row(
                  children: [
                    Text(
                      '£$_salePrice',
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 1,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      '£$_price',
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 2),
                    ),
                  ],
                )
              : Text(
                  '£$_price',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 2),
                ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal * 25,
          height: SizeConfig.blockSizeVertical * 9,
          child: SingleChildScrollView(
            child: Text(
              _decsription,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 0.8),
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeHorizontal * 1,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Row(
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: IconButton(
                              onPressed: () => addorplus!(false),
                              icon: Icon(
                                FontAwesomeIcons.minusSquare,
                                size: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              color: accentColor,
                            ),
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 4,
                            width: SizeConfig.blockSizeHorizontal * 6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: footerColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$_quantity',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 1),
                              ),
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: IconButton(
                              onPressed: () => addorplus!(true),
                              icon: Icon(
                                FontAwesomeIcons.plusSquare,
                                size: SizeConfig.blockSizeHorizontal * 1.5,
                              ),
                              color: accentColor,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: accentColor,
                  side: BorderSide(
                    width: 0.8,
                    color: accentColor,
                  ),
                  fixedSize: Size(
                    SizeConfig.blockSizeHorizontal * 12,
                    SizeConfig.blockSizeVertical * 5,
                  ),
                ),
                onPressed: () {
                  addtoCart();
                  print('addtoCart');
                },
                child: Text(
                  'Add To Cart',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 0.9),
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 1,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: accentColor,
                  fixedSize: Size(
                    SizeConfig.blockSizeHorizontal * 12,
                    SizeConfig.blockSizeVertical * 5,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Buy Now',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
