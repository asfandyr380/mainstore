import 'dart:ui';

import 'package:flutter/material.dart';
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
          child: Column(
            children: [
              Header(),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 0.5),
                      width: SizeConfig.blockSizeHorizontal * 18,
                      height: SizeConfig.blockSizeVertical * 60,
                      child: Stack(
                        children: [
                          Positioned(
                            left: SizeConfig.blockSizeHorizontal * 1.6,
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 15,
                              height: SizeConfig.blockSizeVertical * 15,
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                shape: BoxShape.circle,
                                border: Border.all(width: 0.5),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 6),
                            width: SizeConfig.blockSizeHorizontal * 18,
                            height: SizeConfig.blockSizeVertical * 50,
                            child: CustomPaint(
                              painter: MyPainter(color: footerColor),
                            ),
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
      ..strokeWidth = 2;
    var path = Path();
    final double startPoint = size.width * 0.42;
    final double rheight = 30;
    path.moveTo(startPoint, rheight);
    path.moveTo(0, rheight);
    path.lineTo(71, rheight);
    path.moveTo(startPoint + 80.5, rheight);
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
