import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';

class QuickLinks extends StatelessWidget {
  final String pageName;
  QuickLinks({required this.pageName});
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 0.6,
        ),
        alignment: Alignment.topLeft,
        child: Text(
          pageName,
          style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 1,
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
