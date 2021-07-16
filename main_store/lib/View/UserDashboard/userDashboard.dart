import 'package:flutter/material.dart';
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
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 1,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: SizeConfig.blockSizeVertical * 10,
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 1),
                                  ),
                                ),
                              ),
                              Container(
                                height: SizeConfig.blockSizeVertical * 50,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
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
