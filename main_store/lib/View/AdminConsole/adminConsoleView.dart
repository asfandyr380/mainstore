import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
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
            Container(
              child: Row(
                children: [
                  Container(
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
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 89,
                      width: SizeConfig.blockSizeHorizontal * 10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 1,
                            top: SizeConfig.blockSizeVertical * 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Dashboard',
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 1.5,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    color: accentColor,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Color(0xA9A9A9A9),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Products',
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 1.5,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  size: SizeConfig.blockSizeHorizontal * 3,
                                ),
                              ],
                            ),
                            Divider(
                              color: Color(0xA9A9A9A9),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Orders',
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 1.5,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  size: SizeConfig.blockSizeHorizontal * 3,
                                ),
                              ],
                            ),
                            Divider(
                              color: Color(0xA9A9A9A9),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Stores',
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 1.5,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  size: SizeConfig.blockSizeHorizontal * 3,
                                ),
                              ],
                            ),
                            Divider(
                              color: Color(0xA9A9A9A9),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Help',
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 1.5,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
