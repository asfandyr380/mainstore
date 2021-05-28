import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';

class QuickLinks extends StatelessWidget {
  final String pageName;
  QuickLinks({required this.pageName});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6),
      alignment: Alignment.topLeft,
      child: FittedBox(
        child: Text(
          pageName,
          style: TextStyle(fontSize: 15, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
