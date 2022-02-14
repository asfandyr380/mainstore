import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Componants/Header/header_view.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/UserDashboard/userDashboard.dart';
import 'package:main_store/View/UserDashboard/userInvoiceViewModel.dart';
import 'package:stacked/stacked.dart';

class OrderInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<InvoiceViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: Color(0xf7f7f7f7),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Header(type: HeaderViewType.searchable),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                        )
                      ]),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 0.5,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: SizeConfig.blockSizeVertical * 50,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left:
                                          SizeConfig.blockSizeHorizontal * 1.6,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 15,
                                        height:
                                            SizeConfig.blockSizeVertical * 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(width: 0.5),
                                        ),
                                        child: FaIcon(
                                          FontAwesomeIcons.user,
                                          size: SizeConfig.blockSizeHorizontal *
                                              4,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    UserSideBar(),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.blockSizeVertical * 7,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height:
                                              SizeConfig.blockSizeVertical * 1,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Color(0x70707070),
                                            ),
                                          ),
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  75,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: SizeConfig
                                                            .blockSizeHorizontal *
                                                        3),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Image(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            8,
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            12,
                                                        image: AssetImage(
                                                          'assets/images/logo.png',
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          8,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Invoice #1',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1.25,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                0.5,
                                                          ),
                                                          Text(
                                                            'Date: 3 Dec,2020',
                                                            style: TextStyle(
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    0.75),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'From: ',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1.25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            'Store Name',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            'Store Address .................................................',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            'Phone: +445-442-9745',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'To: ',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1.25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            'Customer Name',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            'Customer Address .................................................',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                2,
                                                          ),
                                                          Text(
                                                            'Phone: +447-546-8817',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: SizeConfig
                                                          .blockSizeHorizontal *
                                                      7,
                                                ),
                                                child: Divider(),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                              ),
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '#',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .blockSizeVertical *
                                                              10,
                                                        ),
                                                        Text(
                                                          'Item',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .blockSizeVertical *
                                                              20,
                                                        ),
                                                        Text(
                                                          'Store Name',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .blockSizeVertical *
                                                              30,
                                                        ),
                                                        Text(
                                                          'Unit Cost',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .blockSizeVertical *
                                                              10,
                                                        ),
                                                        Text(
                                                          'Qty',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .blockSizeVertical *
                                                              10,
                                                        ),
                                                        Text(
                                                          'Total',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    2,
                                              ),
                                              for (int i = 0; i < 4; i++)
                                                Container(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      60,
                                                  color: i % 2 == 0
                                                      ? Color(0xF2F2F8F8)
                                                      : null,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '${i + 1}',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .blockSizeVertical *
                                                                10,
                                                          ),
                                                          Text(
                                                            'Rice',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .blockSizeVertical *
                                                                20,
                                                          ),
                                                          Text(
                                                            'Store Name',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .blockSizeVertical *
                                                                32,
                                                          ),
                                                          Text(
                                                            '£ 10',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .blockSizeVertical *
                                                                13,
                                                          ),
                                                          Text(
                                                            '5',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .blockSizeVertical *
                                                                11,
                                                          ),
                                                          Text(
                                                            '£ 50',
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .blockSizeVertical *
                                                                5,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              7),
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          25,
                                                      child: Column(
                                                        children: [
                                                          Divider(
                                                            color: Colors.black,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Subtotal '),
                                                              Text('£ 200')
                                                            ],
                                                          ),
                                                          Divider(
                                                            color: Colors.black,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  'Discount(20%) '),
                                                              Text('£ 40')
                                                            ],
                                                          ),
                                                          Divider(
                                                            color: Colors.black,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Tax(7%) '),
                                                              Text('£ 14')
                                                            ],
                                                          ),
                                                          Divider(
                                                            color: Colors.black,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Total'),
                                                              Text('£ 254')
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          5,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              5),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: accentColor,
                                                        ),
                                                        onPressed: () {},
                                                        child: Text(
                                                            'Print Invoice'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          5,
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
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => InvoiceViewModel());
  }
}
