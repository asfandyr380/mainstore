import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class SearchBarRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 7),
          child: Image.asset(
            '/Users/hamidu/StudioProjects/mainstore/main_store/assets/images/logo.png',
            height: SizeConfig.blockSizeVertical * 15,
            width: SizeConfig.blockSizeHorizontal * 7,
          ),
        ),
        // SEARCHBOX ****
        Row(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 5,
              width: SizeConfig.blockSizeHorizontal * 45,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Product...',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF959595),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: accentColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(0),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 5,
              width: SizeConfig.blockSizeHorizontal * 6,
              child: Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
                size: 20,
              ),
              decoration: BoxDecoration(
                color: Color(0xff40a944),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
