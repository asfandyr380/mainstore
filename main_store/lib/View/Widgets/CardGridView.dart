import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Widgets/productListingCard.dart';

class CardGridView extends StatelessWidget {
  final List<ProductsModel>? productDetails;
  final int? crossAxixCount;
  CardGridView({this.productDetails, this.crossAxixCount});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int _crossAxisCount = crossAxixCount ?? 4;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical * 2,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _crossAxisCount,
        ),
        itemCount: productDetails!.length,
        itemBuilder: (context, i) {
          return ProductListingCards(
            productName: productDetails![i].name,
            categoryName: productDetails![i].by,
            productPrice: productDetails![i].productPrice,
            image: productDetails![i].images![0],
            salePrice: productDetails![i].salePrice,
            onSale: productDetails![i].onSale,
          );
        },
      ),
    );
  }
}
