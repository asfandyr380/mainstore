import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/categoryModel.dart';
import 'package:stacked/stacked.dart';
import 'SideNavViewModel.dart';

class SideNavMenu extends StatelessWidget {
  final bool? productMenu;
  SideNavMenu({this.productMenu});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _productMenu = productMenu ?? false;
    return ViewModelBuilder<SideNavViewModel>.reactive(
      viewModelBuilder: () => SideNavViewModel(),
      onModelReady: (model) => model.fetchCategorys(),
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
            for (var cate in model.catelist)
              Category(
                items: cate,
              )
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final CategoryModel? items;
  const Category({this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: Text("${items!.cateName}"),
        textColor: accentColor,
        iconColor: accentColor,
        childrenPadding:
            EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
        children: [
          for (var item in items!.subCategory)
            SubItem(
              title: item.cateName,
              items: item.subCate,
            )
        ],
      ),
    );
  }
}

class SubItem extends StatelessWidget {
  final String? title;
  final List<String>? items;
  SubItem({this.items, this.title});
  @override
  Widget build(BuildContext context) {
    return items!.isNotEmpty
        ? ExpansionTile(
            title: Text(title!),
            textColor: accentColor,
            iconColor: accentColor,
            childrenPadding:
                EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
            children: [
              for (var item in items!)
                ListTile(
                  title: Text(item),
                ),
            ],
          )
        : ListTile(
            title: Text(title!),
          );
  }
}
