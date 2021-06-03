import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:stacked/stacked.dart';
import 'SideNavViewModel.dart';

class SideNavMenu extends StatefulWidget {
  @override
  _SideNavMenuState createState() => _SideNavMenuState();
}

class _SideNavMenuState extends State<SideNavMenu> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SideNavViewModel>.reactive(
      viewModelBuilder: () => SideNavViewModel(),
      builder: (context, model, child) => Container(
        width: SizeConfig.blockSizeHorizontal * 20,
        height: SizeConfig.blockSizeVertical * 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
          border: Border.all(width: 0.1),
        ),
        child: ListView(
          children: [
            Container(
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
            ),
            Category()
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
  const SubItem({Key? key}) : super(key: key);

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
