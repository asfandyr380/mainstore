import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
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
              Column(
                children: [
                  Container(
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
                              fontSize: SizeConfig.blockSizeVertical * 3),
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
                          children: [
                            Checkbox(
                              side: BorderSide(width: 1),
                              value: false,
                              onChanged: (val) {},
                              activeColor: accentColor,
                            ),
                            Text('UK Grocery Store'),
                          ],
                        ),
                        Divider(
                          color: footerColor,
                          thickness: 1,
                        )
                      ],
                    ),
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
