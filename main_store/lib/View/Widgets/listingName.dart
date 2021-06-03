import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class ListingName extends StatelessWidget {
  final String? listingName;
  const ListingName({this.listingName});

  @override
  Widget build(BuildContext context) {
    String _listingName = listingName ?? '';
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _listingName,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 4,
            width: SizeConfig.blockSizeHorizontal * 5,
            color: accentColor,
          ),
        ],
      ),
    );
  }
}
