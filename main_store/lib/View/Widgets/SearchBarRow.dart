import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';

class SearchBarRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Image.asset(
            'assets/images/logo.png',
            height: 150,
            width: 150,
          ),
        ),
        // SEARCHBOX ****
        Row(
          children: [
            Container(
              height: 30,
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Product...',
                  hintStyle: TextStyle(
                    fontSize: 10,
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
              height: 30,
              width: 50,
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
        Row(
          children: [
            Icon(
              FontAwesomeIcons.phoneVolume,
              size: 30,
              color: Color(0xff40a944),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '07304137580',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Customer Support',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
