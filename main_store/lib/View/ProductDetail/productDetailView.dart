import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Widgets/snapshotCrousel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/ProductListingRows/ProductListingRows.dart';
import 'package:main_store/View/ProductDetail/productDetailViewMode.dart';
import 'package:stacked/stacked.dart';

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
                child: Header(),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 5,
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
  ProductDetails(
      {this.salePrice,
      this.by,
      this.description,
      this.name,
      this.price,
      this.onSale});
  @override
  Widget build(BuildContext context) {
    String _name = name ?? '';
    String _by = by ?? '';
    double _price = price ?? 0;
    String _decsription = description ?? dumpyProductDetail;
    double _salePrice = salePrice ?? 0;
    bool _onSale = onSale ?? false;
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
              Text(
                'Quantity:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeHorizontal * 0.8),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 0.5,
              ),
              Container(
                alignment: Alignment.center,
                height: SizeConfig.blockSizeVertical * 3,
                width: SizeConfig.blockSizeHorizontal * 4.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  '1',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                ),
              ),
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
                onPressed: () {},
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
