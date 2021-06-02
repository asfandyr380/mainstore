import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';

class ProductListNextArrowButton extends StatelessWidget {
  final Widget? icon;
  ProductListNextArrowButton({this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
        color: footerColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: icon,
    );
  }
}
