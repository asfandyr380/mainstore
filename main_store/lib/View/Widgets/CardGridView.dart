import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Widgets/productListingCard.dart';

class CardGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: 15,
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
