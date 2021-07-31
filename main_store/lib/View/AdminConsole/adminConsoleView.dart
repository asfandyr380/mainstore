import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/AdminConsole/adminConsoleViewModel.dart';
import 'package:stacked/stacked.dart';

class AdminConsoleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<AdminConsoleViewModel>.reactive(
      viewModelBuilder: () => AdminConsoleViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xf7f7f7f7),
        body: Column(
          children: [
            AdminHeader(),
            Container(
              // Side NavBar
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Container(
                          height: SizeConfig.blockSizeVertical * 89,
                          width: SizeConfig.blockSizeHorizontal * 12.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Drawer(
                            child: leftSideNav(),
                          ),
                        ),
                        Column(
                          //Dashboard Layout
                          children: [
                            Container(
                              height: SizeConfig.blockSizeVertical * 89,
                              width: SizeConfig.blockSizeHorizontal * 87.5,
                              decoration: BoxDecoration(
                                color: Color(0xf7f7f7f7),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.blockSizeVertical * 3),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        dashItems(label: 'Order'),
                                        dashItems(label: 'Messages'),
                                        dashItems(label: 'Pending Products'),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.blockSizeVertical * 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          dashItems(label: 'Stores'),
                                          dashItems(label: 'Returns'),
                                          dashItems(label: 'Closed Stores'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Header
      child: Row(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: SizeConfig.blockSizeVertical * 10,
              width: SizeConfig.blockSizeHorizontal * 100,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2.5),
                width: SizeConfig.blockSizeHorizontal * 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: SizeConfig.blockSizeHorizontal * 100,
                      width: SizeConfig.blockSizeHorizontal * 10,
                      child: Image(
                        width: SizeConfig.blockSizeHorizontal * 80,
                        height: SizeConfig.blockSizeVertical * 120,
                        image: AssetImage(
                          'assets/images/logo.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      child: FaIcon(
                        FontAwesomeIcons.userAlt,
                        size: SizeConfig.blockSizeHorizontal * 2.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class leftSideNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
      child: ListView(
        children: [
          ListTile(
            title: Text(
              'Dashboard',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 1.5,
                fontFamily: 'Lato',
              ),
            ),
          ),
          Divider(
            color: Color(0xA9A9A9A9),
          ),
          ExpansionTile(
            children: [
              Text('Add Product'),
              Text('Manage Products'),
            ],
            title: Text(
              'Products',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 1.5,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
              Icons.arrow_right,
              size: SizeConfig.blockSizeHorizontal * 3,
            ),
          ),
          Divider(
            color: Color(0xA9A9A9A9),
          ),
          ListTile(
            title: Text(
              'Orders',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 1.5,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
              Icons.arrow_right,
              size: SizeConfig.blockSizeHorizontal * 3,
            ),
          ),
          Divider(
            color: Color(0xA9A9A9A9),
          ),
          ListTile(
            title: Text(
              'Stores',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 1.5,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
              Icons.arrow_right,
              size: SizeConfig.blockSizeHorizontal * 3,
            ),
          ),
          Divider(
            color: Color(0xA9A9A9A9),
          ),
          ListTile(
            title: Text(
              'Help',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 1.5,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class dashItems extends StatelessWidget {
  final String? itemCount;
  final String label;
  dashItems({this.itemCount, required this.label});
  @override
  Widget build(BuildContext context) {
    String _itemCount = itemCount ?? '0';
    return Container(
      height: SizeConfig.blockSizeVertical * 20,
      width: SizeConfig.blockSizeHorizontal * 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          begin: Alignment(0.9, -0.59),
          end: Alignment(-1.0, 1.18),
          colors: [const Color(0x944d9650), const Color(0xff40a944)],
          stops: [0.0, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(3, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_itemCount',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.blockSizeHorizontal * 3,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.blockSizeHorizontal * 2,
            ),
          ),
        ],
      ),
    );
  }
}
