import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Widgets/productListingCard.dart';

class CardGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical * 2,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 20,
        itemBuilder: (context, i) {
          return ProductListingCards(
            productName: 'Name',
            categoryName: 'name',
            productPrice: '150',
          );
        },
      ),
    );
  }
}
