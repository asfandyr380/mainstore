import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';

class BrandsCard extends StatelessWidget {
  // TODO: Display Images From BackEnd
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeVertical * 8,
      width: SizeConfig.blockSizeHorizontal * 10,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 0.5),
        ],
      ),
    );
  }
}
