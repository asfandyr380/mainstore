import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Header/HeaderViewModel.dart';
import 'package:main_store/View/Widgets/SearchBarRow.dart';
import 'package:main_store/View/Widgets/drop_Down.dart';
import 'package:stacked/stacked.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<HeaderViewModel>.reactive(
      viewModelBuilder: () => HeaderViewModel(),
      builder: (context, model, child) => Column(
        children: [
          Row(
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(FontAwesomeIcons.facebookF, size: 15),
                    Icon(FontAwesomeIcons.twitter, size: 15),
                    Icon(FontAwesomeIcons.instagram, size: 15),
                    Icon(FontAwesomeIcons.pinterestP, size: 15),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 33),
                child: Text('Free Shipping Over 12\$ Order'),
              )
            ],
          ),
          Divider(),
          // Second Row with logo search box and contact
          SearchBarRow(),
          //LISTVIEW
          Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 3,
              right: SizeConfig.blockSizeHorizontal * 3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(child: Text('Home')),
                Dropdown(
                    items: item,
                    onChange: (newVal) =>
                        model.onDropDownChange(newVal, item[0]),
                    dropdownVal: item[0]),
                Dropdown(
                    items: item1,
                    onChange: (newVal) =>
                        model.onDropDownChange(newVal, item1[0]),
                    dropdownVal: item1[0]),
                Dropdown(
                    items: item2,
                    onChange: (newVal) =>
                        model.onDropDownChange(newVal, item2[0]),
                    dropdownVal: item2[0]),
                Dropdown(
                    items: item3,
                    onChange: (newVal) =>
                        model.onDropDownChange(newVal, item3[0]),
                    dropdownVal: item3[0]),
                Container(child: Text('About Us')),
                Container(child: Text('Contact Us')),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
