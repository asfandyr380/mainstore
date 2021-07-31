import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/AdminConsole/adminConsoleView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/UserDashboard/userDashboard.dart';
import 'package:main_store/View/UserDashboard/userOrderViewModel.dart';
import 'package:main_store/View/Widgets/DropDown/drop_Down.dart';
import 'package:main_store/View/Widgets/DropDown/invoiceDropdown.dart';
import 'package:stacked/stacked.dart';

class UserOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<UserOrderViewModel>.reactive(
      viewModelBuilder: () => UserOrderViewModel(),
      builder: (model, context, child) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Header(),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 20,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 0.5),
                              height: SizeConfig.blockSizeVertical * 60,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: SizeConfig.blockSizeHorizontal * 1.6,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      height: SizeConfig.blockSizeVertical * 15,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 0.5),
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.user,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 4,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  UserSideBar(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 9.5),
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 80,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 6.5),
                              child: Row(
                                children: [
                                  Text(
                                    'Status :',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  StatusDropdown(
                                    items: [
                                      'Pending Orders',
                                      'In Process',
                                      'Out For Delivery',
                                      'Completed Orders'
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 5),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 67,
                              child: PendingOrdersContainer(
                                content: OrdersTable(),
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
        ),
      ),
    );
  }
}

class OrdersTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(SizeConfig.blockSizeHorizontal * 0.01),
      },
      border: TableBorder.all(
          color: Colors.black, style: BorderStyle.solid, width: 1),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Color(0xEEEEEEEE),
          ),
          children: [
            TableColumn(
              isHeading: true,
              tableLabel: 'Sr. \nNo.',
              tableStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 1),
            ),
            TableColumn(
              isHeading: true,
              tableLabel: 'User Name',
              tableStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 1),
            ),
            TableColumn(
              isHeading: true,
              tableLabel: 'Sub Total',
              tableStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 1),
            ),
            TableColumn(
              isHeading: true,
              tableLabel: 'Discount',
              tableStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 1),
            ),
            TableColumn(
              isHeading: true,
              tableLabel: 'Total',
              tableStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 1),
            ),
            TableColumn(
              isHeading: true,
              tableLabel: 'Action',
              tableStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 1),
            ),
          ],
        ),
        for (int i = 0; i < 4; i++)
          TableRow(
            children: [
              TableColumn(
                tableLabel: '${i + 1}',
                tableStyle: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 1,
                ),
              ),
              TableColumn(
                tableLabel: 'Adam123',
                tableStyle: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 1,
                ),
              ),
              TableColumn(
                tableLabel: '£100',
                tableStyle: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 1,
                ),
              ),
              TableColumn(
                tableLabel: '20%',
                tableStyle: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 1,
                ),
              ),
              TableColumn(
                tableLabel: '£80',
                tableStyle: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Cart Preview',
                              style: TextStyle(
                                color: accentColor,
                                fontSize: SizeConfig.blockSizeHorizontal * 1,
                              ),
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
      ],
    );
  }
}

class PendingOrdersContainer extends StatelessWidget {
  final Widget? content;
  PendingOrdersContainer({
    this.content,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: SizeConfig.blockSizeVertical * 5,
            child: content!,
          ),
        ],
      ),
    );
  }
}
