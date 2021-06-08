import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:stacked/stacked.dart';
import 'SideNavViewModel.dart';

class SideNavMenu extends StatelessWidget {
  final bool? productMenu;
  SideNavMenu({this.productMenu});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _productMenu = productMenu ?? false;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SideNavViewModel(),
      builder: (context, model, child) => Container(
        width: SizeConfig.blockSizeHorizontal * 20,
        height: !_productMenu
            ? SizeConfig.blockSizeVertical * 52
            : SizeConfig.blockSizeVertical * 130,
        decoration: !_productMenu
            ? BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                border: Border.all(width: 0.1),
              )
            : BoxDecoration(),
        child: ListView(
          children: [
            !_productMenu
                ? Container(
                    width: SizeConfig.blockSizeHorizontal * 15,
                    height: SizeConfig.blockSizeVertical * 5,
                    decoration: BoxDecoration(color: accentColor),
                    child: Center(
                      child: Text(
                        'All Category',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeHorizontal * 1.5),
                      ),
                    ),
                  )
                : Container(),
            Category(),
            Category(),
            Category(),
            Category(),
            Category(),
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final List? items;
  const Category({this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: Text('Grocery'),
        textColor: accentColor,
        iconColor: accentColor,
        childrenPadding:
            EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
        children: [
          ListTile(
            title: Text('items 1'),
          ),
          ListTile(
            title: Text('items 1'),
          ),
          SubItem()
        ],
      ),
    );
  }
}

class SubItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('SubMenu1'),
      textColor: accentColor,
      iconColor: accentColor,
      childrenPadding:
          EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
      children: [
        ListTile(
          title: Text('items 1'),
        ),
      ],
    );
  }
}
