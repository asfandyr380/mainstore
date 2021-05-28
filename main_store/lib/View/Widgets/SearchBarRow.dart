import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class SearchBarRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 50),
          width: SizeConfig.blockSizeHorizontal * 9,
          height: SizeConfig.blockSizeVertical * 13,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ),
        // SEARCHBOX ****
        Container(
          child: Row(
            children: [
              Container(
                height: SizeConfig.blockSizeVertical * 5,
                width: SizeConfig.blockSizeHorizontal * 40,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Product...',
                    hintStyle: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF959595),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
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
                width: SizeConfig.blockSizeHorizontal * 5,
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
        ),
        Container(
          padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Text('Login'),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.heart),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.shoppingCart),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
