import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Widgets/order_summary.dart';
import 'package:stacked/stacked.dart';
import 'CartViewModel.dart';

class CartViewPage extends StatefulWidget {
  @override
  _CartViewPageState createState() => _CartViewPageState();
}

class _CartViewPageState extends State<CartViewPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => CartViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal * 1),
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 2,
                            horizontal: SizeConfig.blockSizeHorizontal * 3),
                        width: SizeConfig.blockSizeHorizontal * 30,
                        height: SizeConfig.blockSizeVertical * 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: footerColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shopping Cart(3)',
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 2),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  side: BorderSide(width: 1),
                                  value: false,
                                  onChanged: (val) {},
                                  activeColor: accentColor,
                                ),
                                Text('Select All')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 2,
                            horizontal: SizeConfig.blockSizeHorizontal * 3),
                        width: SizeConfig.blockSizeHorizontal * 30,
                        height: SizeConfig.blockSizeVertical * 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: footerColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      side: BorderSide(
                                          width: 1, color: footerColor),
                                      value: false,
                                      onChanged: (val) {},
                                      activeColor: accentColor,
                                    ),
                                    Text(
                                      'UK Grocery Store',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical * 2),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'shipping charges:',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  0.7),
                                    ),
                                    Text(
                                      '\$ 2.00',
                                      style: TextStyle(
                                          color: accentColor,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  0.7),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              color: footerColor,
                              thickness: 1,
                            ),
                            //product summary row
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.blockSizeHorizontal * 1,
                                  vertical: SizeConfig.blockSizeVertical * 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        side: BorderSide(
                                            width: 1, color: footerColor),
                                        value: false,
                                        onChanged: (val) {},
                                        activeColor: accentColor,
                                      ),
                                      Container(
                                        height:
                                            SizeConfig.blockSizeVertical * 8,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 7,
                                        child: Image.asset(
                                            'assets/images/capture.png'),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Hershey’s Syrup'),
                                          Text(
                                            'USD \$ 3.00',
                                            style: TextStyle(
                                                color: accentColor,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    0.7),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Quantity:',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    0.7),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.plusSquare,
                                                size: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                                color: accentColor,
                                              ),
                                              Container(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: footerColor,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '1',
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            0.7),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.trashAlt,
                                            size:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                            color: accentColor,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.minusSquare,
                                            size:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                            color: accentColor,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 2,
                            horizontal: SizeConfig.blockSizeHorizontal * 3),
                        width: SizeConfig.blockSizeHorizontal * 30,
                        height: SizeConfig.blockSizeVertical * 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: footerColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      side: BorderSide(
                                          width: 1, color: footerColor),
                                      value: false,
                                      onChanged: (val) {},
                                      activeColor: accentColor,
                                    ),
                                    Text(
                                      'MS Store',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  1),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'shipping charges:',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  0.7),
                                    ),
                                    Text(
                                      '\$ 3.00',
                                      style: TextStyle(
                                          color: accentColor,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  0.7),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              color: footerColor,
                              thickness: 1,
                            ),
                            //product summary row
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.blockSizeHorizontal * 1,
                                  vertical: SizeConfig.blockSizeVertical * 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        side: BorderSide(
                                            width: 1, color: footerColor),
                                        value: false,
                                        onChanged: (val) {},
                                        activeColor: accentColor,
                                      ),
                                      Container(
                                        height:
                                            SizeConfig.blockSizeVertical * 8,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 7,
                                        child: Image.asset(
                                            'assets/images/capture.png'),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Hershey’s Syrup'),
                                          Text(
                                            'USD \$ 3.00',
                                            style: TextStyle(
                                                color: accentColor,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    0.7),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Quantity:',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    0.7),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.plusSquare,
                                                size: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                                color: accentColor,
                                              ),
                                              Container(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: footerColor,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '1',
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            0.7),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.trashAlt,
                                            size:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                            color: accentColor,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.minusSquare,
                                            size:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                            color: accentColor,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: footerColor,
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.blockSizeHorizontal * 1,
                                  vertical: SizeConfig.blockSizeVertical * 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        side: BorderSide(
                                            width: 1, color: footerColor),
                                        value: false,
                                        onChanged: (val) {},
                                        activeColor: accentColor,
                                      ),
                                      Container(
                                        height:
                                            SizeConfig.blockSizeVertical * 8,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 7,
                                        child: Image.asset(
                                            'assets/images/capture.png'),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Hershey’s Syrup'),
                                          Text(
                                            'USD \$ 3.00',
                                            style: TextStyle(
                                                color: accentColor,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    0.7),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Quantity:',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    0.7),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.plusSquare,
                                                size: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                                color: accentColor,
                                              ),
                                              Container(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: footerColor,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '1',
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            0.7),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.trashAlt,
                                            size:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                            color: accentColor,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.minusSquare,
                                            size:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                            color: accentColor,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  OrderSummary(
                    checkout: true,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
