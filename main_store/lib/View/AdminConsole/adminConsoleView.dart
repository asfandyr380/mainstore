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
            Row(
              children: [
                Container(
                  height: SizeConfig.blockSizeVertical * 10,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: SizeConfig.blockSizeHorizontal * 100,
                          width: SizeConfig.blockSizeHorizontal * 10,
                          child: Image(
                            image: AssetImage(
                              'assets/images/logo.png',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          child: FaIcon(
                            Icons.person,
                            size: SizeConfig.blockSizeHorizontal * 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 89,
                    width: SizeConfig.blockSizeHorizontal * 15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
