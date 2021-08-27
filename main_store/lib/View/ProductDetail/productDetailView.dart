import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/ReviewModel.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Home/HomeView.dart';
import 'package:main_store/View/Widgets/Mobile_AppBar.dart';
import 'package:main_store/View/Widgets/responsive.dart';
import 'package:main_store/View/Widgets/snapshotCrousel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/ProductDetail/productDetailViewMode.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';

// Responsive Widget
class ProductDetailPage extends StatelessWidget {
  final ProductsModel productDetails;
  const ProductDetailPage({required this.productDetails});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: MobileProductDetailView(details: productDetails),
        tablet: ProductDetailView(productDetails: productDetails),
        desktop: ProductDetailView(productDetails: productDetails));
  }
}

// Desktop View
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
                      cate != "null"
                          ? productDetails.category!.last == cate
                              ? BreadCrumbItem(
                                  onTap: () =>
                                      model.navigateToProductlisting(cate),
                                  content: Text('$cate',
                                      style: TextStyle(color: accentColor)),
                                )
                              : BreadCrumbItem(
                                  onTap: () =>
                                      model.navigateToProductlisting(cate),
                                  content: Text('$cate'),
                                )
                          : BreadCrumbItem(
                              content: Text(''),
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
                        price: productDetails.productPrice!,
                        description: productDetails.description,
                        shortDesc: productDetails.shortDsec,
                        salePrice: productDetails.salePrice,
                        onSale: productDetails.onSale,
                        addorplus: (val) => model.addOrMiuns(val),
                        quantity: model.quantity,
                        isLoading: model.isLoading,
                        addtoCart: (price) {
                          model
                              .addtoCart(productDetails.productId,
                                  productDetails.storeId, price.toString())
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
                        buyNow: () =>
                            model.buyNow(productDetails.productPrice, 0),
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
    controller = CustomGroupController(initSelectedItem: widget.attribute![0]);
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
  final String? shortDesc;
  final double? salePrice;
  final int? onSale;
  final Function(int) addtoCart;
  final Function(bool)? addorplus;
  final int? quantity;
  final bool? isLoading;
  final Function? buyNow;
  final List<AttributeModel>? attribute;
  ProductDetails({
    this.buyNow,
    this.salePrice,
    this.by,
    this.description,
    this.shortDesc,
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
  int _attributePrice = 0;

  @override
  void initState() {
    super.initState();
    if (widget.attribute!.isNotEmpty)
      _attributePrice = widget.attribute![0].price;
  }

  @override
  Widget build(BuildContext context) {
    String _name = widget.name ?? '';
    String _by = widget.by ?? '';
    double _price = widget.price ?? 0;
    String _decsription = widget.description ?? '';
    String _shortDesc = widget.shortDesc ?? '';
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
              ? Text(
                  widget.attribute!.isEmpty
                      ? '£$_salePrice'
                      : '£$_attributePrice',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 2),
                )
              : Text(
                  widget.attribute!.isEmpty ? '£$_price' : '£$_attributePrice',
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
              _shortDesc,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 1),
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
                      _attributePrice = p.toInt();
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
                onPressed: () => widget.buyNow!(),
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

// Mobile View
class MobileProductDetailView extends StatelessWidget {
  final ProductsModel? details;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pageViewController = PageController();
  MobileProductDetailView({this.details});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      onModelReady: (model) {
        model.fetchRelatedProduct(details!.category!);
        model.getReviews();
      },
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
        body: SingleChildScrollView(
          child: Column(
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
                        for (var image in details!.images!)
                          Image.network(
                            '$image',
                            fit: BoxFit.fitWidth,
                          ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 31,
                          bottom: SizeConfig.blockSizeVertical * 1),
                      child: SmoothPageIndicator(
                        controller: pageViewController,
                        count: 4,
                        axisDirection: Axis.horizontal,
                        onDotClicked: (i) {
                          pageViewController.animateToPage(
                            i,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        effect: ExpandingDotsEffect(
                          expansionFactor: 3,
                          spacing: 8,
                          radius: 16,
                          dotWidth: 10,
                          dotHeight: 10,
                          dotColor: Color(0xFF9E9E9E),
                          activeDotColor: Color(0xFF40A944),
                          paintStyle: PaintingStyle.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        details!.onSale == 1
                            ? Text(
                                '£ ${details!.productPrice}',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 0.5,
                        ),
                        Text(
                          '£ ${details!.productPrice}',
                          style: TextStyle(
                            decoration: details!.onSale == 1
                                ? TextDecoration.lineThrough
                                : null,
                            color: Color(0xFF40A944),
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        '${details!.name}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        '${details!.description}',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                        children: [
                          Text(
                            'Category: ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '${details!.category![0]}',
                            style: TextStyle(
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
                            '${details!.by}',
                            style: TextStyle(
                              color: accentColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: ElevatedButton.icon(
                        label: model.isLoading
                            ? Container(
                                height: SizeConfig.blockSizeVertical * 2,
                                width: SizeConfig.blockSizeHorizontal * 3,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text('Add to Cart'),
                        icon: FaIcon(FontAwesomeIcons.shoppingCart, size: 12),
                        onPressed: () => {
                          model
                              .addtoCart(details!.productId, details!.storeId,
                                  details!.productPrice!.toString())
                              .then((val) {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                message: 'Product Added to Cart',
                              ),
                              displayDuration: Duration(milliseconds: 150),
                            );
                          })
                        },
                        style: ElevatedButton.styleFrom(primary: accentColor),
                      ),
                    ),
                    ReviewDescription(
                      label: 'Description',
                      onTap: () =>
                          _showSheet(context, details!.description!, false),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1.5,
                    ),
                    ReviewDescription(
                      label: 'Reviews',
                      onTap: () => _showSheet(
                          context, details!.description!, true,
                          reviews: model.reviewlist),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 3,
                    ),
                    ProductListingRowMobile(
                      listingName: 'Related Products',
                      productDetails: model.relatedlist,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showSheet(BuildContext ctx, String desc, bool onReview,
    {List<ReviewModel>? reviews}) {
  showFlexibleBottomSheet<void>(
    minHeight: 0,
    initHeight: 0.5,
    maxHeight: 1,
    context: ctx,
    builder: (ctx, controller, bottomsheet) => onReview
        ? _buildReviewSheet(ctx, controller, bottomsheet, reviews: reviews)
        : _buildDescriptionSheet(
            ctx,
            controller,
            bottomsheet,
            desc: desc,
          ),
    anchors: [0, 0.5, 1],
  );
}

Widget _buildReviewSheet(BuildContext context,
    ScrollController scrollController, double bottomSheetOffset,
    {List<ReviewModel>? reviews}) {
  return SafeArea(
    child: Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Reviews',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeHorizontal * 4),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            for (var review in reviews!)
              ReviewCardMobile(
                  user: review.user,
                  comment: review.message,
                  rating: review.rating),
          ],
        ),
      ),
    ),
  );
}

class ReviewCardMobile extends StatelessWidget {
  final String? comment;
  final int? rating;
  final String? user;
  const ReviewCardMobile({this.comment, this.rating, this.user});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 10),
          child: Text('$user'),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 0.4,
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal * 80,
          decoration: BoxDecoration(
            color: accentColor,
            gradient: LinearGradient(
              colors: [accentColor.withOpacity(0.5), accentColor],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Text('$comment'),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 0.4,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 75),
          child: RatingBar.builder(
            ignoreGestures: true,
            initialRating: rating!.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: SizeConfig.blockSizeHorizontal * 2,
            itemPadding: EdgeInsets.symmetric(horizontal: 2),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: accentColor,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildDescriptionSheet(BuildContext context,
    ScrollController scrollController, double bottomSheetOffset,
    {String? desc}) {
  return SafeArea(
    child: Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Description',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeHorizontal * 4),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Text('$desc'),
          ],
        ),
      ),
    ),
  );
}

class ReviewDescription extends StatelessWidget {
  final String? label;
  final Function? onTap;
  const ReviewDescription({this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        width: double.infinity,
        height: SizeConfig.blockSizeVertical * 4,
        decoration: BoxDecoration(
          color: footerColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: Text('$label'),
            ),
            Container(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2),
              child: Icon(FontAwesomeIcons.arrowRight, size: 12),
            ),
          ],
        ),
      ),
    );
  }
}
