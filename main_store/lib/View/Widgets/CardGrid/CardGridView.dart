import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/productsModel.dart';
import 'package:main_store/View/Widgets/CardGrid/CardGridViewModel.dart';
import 'package:main_store/View/Widgets/ProductCard/productListingCard.dart';
import 'package:stacked/stacked.dart';

class CardGridView extends StatelessWidget {
  final List<ProductsModel>? productDetails;
  final int? crossAxixCount;
  final bool? disableScroll;
  CardGridView({this.productDetails, this.crossAxixCount, this.disableScroll});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int _crossAxisCount = crossAxixCount ?? 4;
    return ViewModelBuilder<CardGridViewModel>.reactive(
      builder: (context, model, child) => Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 2,
        ),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _crossAxisCount,
          ),
          itemCount: productDetails!.length,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 0.3,
                  horizontal: SizeConfig.blockSizeHorizontal * 0.5),
              width: SizeConfig.blockSizeHorizontal * 5,
              child: ProductListingCards(
                isGrid: true,
                onTap: () => model.navigatetodetails(productDetails![i]),
                productName: productDetails![i].name,
                categoryName: productDetails![i].by,
                productPrice: productDetails![i].productPrice,
                image: productDetails![i].images![0],
                salePrice: productDetails![i].salePrice,
                onSale: productDetails![i].onSale,
              ),
            );
          },
        ),
      ),
      viewModelBuilder: () => CardGridViewModel(),
    );
  }
}
