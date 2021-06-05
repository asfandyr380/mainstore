import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Widgets/order_summary.dart';
import 'package:stacked/stacked.dart';
import 'CartViewModel.dart';

class TickBox extends StatelessWidget {
  final Function(bool?) onTickChange;
  TickBox({required this.onTickChange});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      side: BorderSide(width: 0.5),
      value: false,
      onChanged: (val) => onTickChange(val),
      activeColor: accentColor,
    );
  }
}

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
              Container(
                child: Header(),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          child: SelectAllContainer(),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                        for (int i = 0; i < 2; i++)
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 2,
                            ),
                            child: CartitemsContainer(),
                          ),
                      ],
                    ),
                    OrderSummary(
                      checkout: true,
                    ),
                  ],
                ),
              ),
              Container(
                child: Footer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartitemsContainer extends StatelessWidget {
  final String? storeName;
  final String? shippingCharges;
  CartitemsContainer({this.shippingCharges, this.storeName});
  @override
  Widget build(BuildContext context) {
    String _storeName = storeName ?? '';
    String _shippingCharges = shippingCharges ?? '';
    return Container(
      width: SizeConfig.blockSizeHorizontal * 30,
      height: SizeConfig.blockSizeVertical * 30,
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
                  TickBox(onTickChange: (val) {}),
                  Text(
                    _storeName,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'shipping charges:',
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                  ),
                  Text(
                    '\$ $_shippingCharges',
                    style: TextStyle(
                        color: accentColor,
                        fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                  ),
                ],
              )
            ],
          ),
          Divider(
            color: footerColor,
            thickness: 1,
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 20,
            child: ListView(
              children: [
                for (int i = 0; i < 3; i++) CartItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 1,
          vertical: SizeConfig.blockSizeVertical * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TickBox(onTickChange: (val) {}),
              Container(
                height: SizeConfig.blockSizeVertical * 8,
                width: SizeConfig.blockSizeHorizontal * 7,
                child: Image.asset('assets/images/capture.png'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hershey’s Syrup'),
                  Text(
                    'USD \$ 3.00',
                    style: TextStyle(
                        color: accentColor,
                        fontSize: SizeConfig.blockSizeHorizontal * 0.7),
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
                        fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.plusSquare,
                        size: SizeConfig.blockSizeHorizontal * 1,
                        color: accentColor,
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 2,
                        width: SizeConfig.blockSizeHorizontal * 3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: footerColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.trashAlt,
                    size: SizeConfig.blockSizeHorizontal * 1,
                    color: accentColor,
                  ),
                  Icon(
                    FontAwesomeIcons.minusSquare,
                    size: SizeConfig.blockSizeHorizontal * 1,
                    color: accentColor,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class SelectAllContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 30,
      height: SizeConfig.blockSizeVertical * 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Shopping Cart(3)',
                style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 2),
              ),
            ),
            Container(
              child: Row(
                children: [
                  TickBox(onTickChange: (val) {}),
                  Text('Select All'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
