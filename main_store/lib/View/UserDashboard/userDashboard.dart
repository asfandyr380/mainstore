import 'dart:ui';

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/UserDashboard/userDashboardViewModel.dart';
import 'package:stacked/stacked.dart';

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<UserdashboardViewModel>.reactive(
      viewModelBuilder: () => UserdashboardViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Column(
              children: [
                Container(
                  child: Header(),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 2,
                    )
                  ]),
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
                                  UserSideBar(),
                                  Positioned(
                                    left: SizeConfig.blockSizeHorizontal * 1.6,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      height: SizeConfig.blockSizeVertical * 15,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                dashItems(label: 'Pending Products'),
                                SizedBox(
                                  width: SizeConfig.blockSizeVertical * 6,
                                ),
                                dashItems(label: 'Orders'),
                                SizedBox(
                                  width: SizeConfig.blockSizeVertical * 6,
                                ),
                                dashItems(label: 'Messages'),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 10,
                            ),
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 67,
                              child: PendingOrdersContainer(
                                label: 'Pending Orders',
                                content: PendingOrdersTable(),
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

class MyPainter extends CustomPainter {
  Color? color;
  MyPainter({@required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = color!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    var path = Path();
    final double startPoint = SizeConfig.blockSizeHorizontal * 8.75;
    final double rheight = 30;
    path.moveTo(startPoint, rheight);
    path.moveTo(0, rheight);
    path.lineTo(SizeConfig.blockSizeHorizontal * 10.30, rheight);
    path.moveTo(startPoint + 1, rheight);
    path.lineTo(size.width, rheight);
    path.lineTo(size.width, size.height);
    path.moveTo(0, rheight);
    path.lineTo(0, size.height);
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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

class userSideNav extends StatelessWidget {
  final String title;
  userSideNav({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: SizeConfig.blockSizeHorizontal * 15,
      height: SizeConfig.blockSizeVertical * 5,
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 1,
      ),
      child: Text(
        '$title',
        style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 1,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SideBarText extends StatelessWidget {
  final String sideBarText;
  final bool? onUserDashboard;

  final FontWeight? userFontWeight;
  SideBarText({
    required this.sideBarText,
    this.userFontWeight,
    this.onUserDashboard,
  });
  @override
  Widget build(BuildContext context) {
    bool _onUserDashboard = onUserDashboard ?? false;

    return Container(
      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
      child: Text(
        '$sideBarText',
        style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 1.25,
          fontWeight: userFontWeight,
          color: _onUserDashboard ? accentColor : null,
        ),
      ),
    );
  }
}

class PendingOrdersContainer extends StatelessWidget {
  final Widget? content;
  final String? label;
  PendingOrdersContainer({this.content, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: SizeConfig.blockSizeVertical * 5,
            child: Text(
              '$label',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 1.75,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content!,
        ],
      ),
    );
  }
}

class PendingOrdersTable extends StatelessWidget {
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

class TableColumn extends StatelessWidget {
  final String? tableLabel;
  final TextStyle? tableStyle;
  final bool? isHeading;
  TableColumn({required this.tableLabel, this.tableStyle, this.isHeading});
  @override
  Widget build(BuildContext context) {
    bool _isHeading = isHeading ?? false;
    return Container(
      margin: EdgeInsets.only(
        top: _isHeading ? SizeConfig.blockSizeVertical * 2 : 10,
      ),
      child: Center(
        child: Text(
          '$tableLabel',
          overflow: TextOverflow.ellipsis,
          style: tableStyle,
        ),
      ),
    );
  }
}

class UserSideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 6),
      width: SizeConfig.blockSizeHorizontal * 18,
      height: SizeConfig.blockSizeVertical * 50,
      child: CustomPaint(
        painter: MyPainter(
          color: Colors.black.withOpacity(0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideBarText(
              sideBarText: 'Dashboard',
              userFontWeight: FontWeight.bold,
              onUserDashboard: true,
            ),
            Divider(
              color: Colors.black.withOpacity(0.5),
              thickness: 0.5,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            SideBarText(
              sideBarText: 'Order',
            ),
            Divider(
              color: Colors.black.withOpacity(0.5),
              thickness: 0.5,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            SideBarText(
              sideBarText: 'Profile Setting',
            ),
            Divider(
              color: Colors.black.withOpacity(0.5),
              thickness: 0.5,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            SideBarText(
              sideBarText: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
