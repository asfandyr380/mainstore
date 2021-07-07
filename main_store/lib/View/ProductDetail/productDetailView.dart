import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Home/HomeView.dart';
import 'package:main_store/View/Widgets/Mobile_AppBar.dart';
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
      onModelReady: (model) {
        model.fetchRelatedProduct(productDetails.category!);
        model.getReviews();
      },
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
                    for (var cate in productDetails.category!)
                      productDetails.category!.last == cate
                          ? BreadCrumbItem(
                              onTap: () => model.navigateToProductlisting(cate),
                              content: Text('$cate',
                                  style: TextStyle(color: accentColor)),
                            )
                          : BreadCrumbItem(
                              onTap: () => model.navigateToProductlisting(cate),
                              content: Text('$cate'),
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
                        attribute: productDetails.attributes,
                        name: productDetails.name,
                        by: productDetails.by,
                        price: productDetails.productPrice,
                        description: productDetails.description,
                        salePrice: productDetails.salePrice,
                        onSale: productDetails.onSale,
                        addorplus: (val) => model.addOrMiuns(val),
                        quantity: model.quantity,
                        isLoading: model.isLoading,
                        addtoCart: (price) {
                          model
                              .addtoCart(productDetails.productId,
                                  productDetails.storeId, price)
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
              DescriptionReviewsPanalHeader(
                onDescPrss: () => model.changeView(),
                onReviewPress: () => model.changeView(),
                onReview: model.onReview,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              model.onReview
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 2),
                      height: SizeConfig.blockSizeVertical * 22,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var review in model.reviewlist)
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 2,
                                horizontal: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              child: ReviewsCard(
                                details: review,
                              ),
                            )
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                        bottom: SizeConfig.blockSizeVertical * 5,
                      ),
                      width: SizeConfig.blockSizeHorizontal * 90,
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
  final Function? onDescPrss;
  final Function? onReviewPress;
  final bool? onReview;
  DescriptionReviewsPanalHeader(
      {this.onDescPrss, this.onReviewPress, this.onReview});
  @override
  Widget build(BuildContext context) {
    bool _onReview = onReview ?? false;
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
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onDescPrss!(),
                child: Text(
                  'Description  | ',
                  style: TextStyle(
                    color: _onReview ? null : accentColor,
                    fontSize: SizeConfig.blockSizeHorizontal * 1.2,
                  ),
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onReviewPress!(),
                child: Text(
                  ' Review',
                  style: TextStyle(
                    color: _onReview ? accentColor : null,
                    fontSize: SizeConfig.blockSizeHorizontal * 1.2,
                  ),
                ),
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

class Attributes extends StatefulWidget {
  final List<AttributeModel>? attribute;
  final ValueChanged<double>? onPriceChange;
  Attributes({this.attribute, this.onPriceChange});

  @override
  _AttributesState createState() => _AttributesState();
}

class _AttributesState extends State<Attributes> {
  CustomGroupController controller = CustomGroupController();

  @override
  void initState() {
    super.initState();
    controller.listen((val) {
      var attr = val as AttributeModel;
      widget.onPriceChange!(attr.price.toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Variants',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 15,
            height: SizeConfig.blockSizeVertical * 10,
            child: CustomGroupedCheckbox.grid(
                controller: controller,
                isScroll: false,
                values: widget.attribute!,
                itemBuilder: (context, i, value, isDisable) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 1,
                      horizontal: SizeConfig.blockSizeHorizontal * 0.7,
                    ),
                    child: AttributeBox(
                      isSelected: value,
                      variant: widget.attribute![i].variant,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class AttributeBox extends StatelessWidget {
  final bool? isSelected;
  final String? variant;
  AttributeBox({this.isSelected, this.variant});

  @override
  Widget build(BuildContext context) {
    bool _isSelected = isSelected ?? false;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          height: SizeConfig.blockSizeVertical * 2,
          width: SizeConfig.blockSizeHorizontal * 5,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
            border: _isSelected ? Border.all(color: accentColor) : null,
          ),
          child: Text(
            '$variant',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}

class ProductDetails extends StatefulWidget {
  final String? name;
  final String? by;
  final double? price;
  final String? description;
  final double? salePrice;
  final int? onSale;
  final Function(double) addtoCart;
  final Function(bool)? addorplus;
  final int? quantity;
  final bool? isLoading;
  final List<AttributeModel>? attribute;
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
    this.isLoading,
    this.attribute,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double _attributePrice = 0;

  @override
  void initState() {
    super.initState();
    if (widget.attribute!.isNotEmpty)
      _attributePrice = widget.attribute![0].price.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    String _name = widget.name ?? '';
    String _by = widget.by ?? '';
    double _price = widget.price ?? 0;
    String _decsription = widget.description ?? dumpyProductDetail;
    double _salePrice = widget.salePrice ?? 0;
    int _onSale = widget.onSale ?? 0;
    int _quantity = widget.quantity ?? 0;
    bool _isLoading = widget.isLoading ?? false;
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
          child: _onSale == 1
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
                      widget.attribute!.isEmpty
                          ? '£$_price'
                          : '$_attributePrice',
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
        widget.attribute!.isEmpty
            ? Container()
            : Container(
                child: Attributes(
                  attribute: widget.attribute,
                  onPriceChange: (p) {
                    setState(() {
                      _attributePrice = p;
                      print("p for price $_attributePrice");
                    });
                  },
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
                              onPressed: () => widget.addorplus!(false),
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
                              onPressed: () => widget.addorplus!(true),
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
                  widget.addtoCart(_attributePrice);
                },
                child: !_isLoading
                    ? Text(
                        'Add To Cart',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 0.9),
                      )
                    : Container(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          color: accentColor,
                        ),
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

class MobileProductDetailView extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      builder: (context, model, child) => Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          elevation: 16,
          // Drawer content to be added
          child: Center(
            child: Text('No Data'),
          ),
        ),
        appBar: mobileAppBar(scaffoldKey),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: SizeConfig.blockSizeVertical * 33,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  child: PageView(
                    controller: pageViewController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Image.network(
                        'https://picsum.photos/seed/861/600',
                        fit: BoxFit.fitWidth,
                      ),
                      Image.network(
                        'https://picsum.photos/seed/782/600',
                        fit: BoxFit.fitWidth,
                      ),
                      Image.network(
                        'https://picsum.photos/seed/792/600',
                        fit: BoxFit.fitWidth,
                      )
                    ],
                  ),
                ),
                // Center(
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //         top: SizeConfig.blockSizeVertical * 31,
                //         bottom: SizeConfig.blockSizeVertical * 1),
                //     child: SmoothPageIndicator(
                //       controller: pageViewController,
                //       count: 4,
                //       axisDirection: Axis.horizontal,
                //       onDotClicked: (i) {
                //         pageViewController.animateToPage(
                //           i,
                //           duration: Duration(milliseconds: 500),
                //           curve: Curves.ease,
                //         );
                //       },
                //       effect: ExpandingDotsEffect(
                //         expansionFactor: 3,
                //         spacing: 8,
                //         radius: 16,
                //         dotWidth: 10,
                //         dotHeight: 10,
                //         dotColor: Color(0xFF9E9E9E),
                //         activeDotColor: Color(0xFF40A944),
                //         paintStyle: PaintingStyle.fill,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '£ 60',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Color(0xFF40A944),
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      'RedBull Energy Drink',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      'lorem ipsum ddfds sdf d  aksfdasd ksjdkfd ksfdksjf akjsdfksj  ksjdksf ksdfj ksdjf sjf kjbjd ',
                      style: TextStyle(
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      children: [
                        Text(
                          'Category: ',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Drinks',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: accentColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      children: [
                        Text(
                          'By: ',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'US Store',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: accentColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: ElevatedButton.icon(
                      label: Text('Add to Cart'),
                      icon: FaIcon(FontAwesomeIcons.shoppingCart),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(primary: accentColor),
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
