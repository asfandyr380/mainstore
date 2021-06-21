import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Widgets/order_summary.dart';
import 'package:stacked/stacked.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
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
      onModelReady: (model) => model.getCart(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                  )
                ]),
                child: Header(),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          child:
                              SelectAllContainer(totalCount: model.itemCount),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                        for (var cart in model.cartlist)
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 2,
                            ),
                            child: CartitemsContainer(
                              cart: cart,
                              onDelete: (ref) => model
                                  .removefromCart(cart.storeName!, ref)
                                  .then(
                                (e) {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      icon: Icon(Icons.delete_forever),
                                      message: 'Product Removed from Cart',
                                    ),
                                    displayDuration:
                                        Duration(milliseconds: 150),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    OrderSummary(
                      subTotal: model.subTotal,
                      total: model.total,
                      shippingfee: model.shipping,
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
  final CartModel cart;
  final Function(DocumentReference)? onDelete;
  CartitemsContainer({required this.cart, this.onDelete});
  @override
  Widget build(BuildContext context) {
    double _shippingCharges = 0;
    print('Products ${cart.products.length}');
    return Container(
      width: SizeConfig.blockSizeHorizontal * 30,
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
                    cart.storeName!,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
                  ),
                ],
              ),
              Container(
                padding:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 1),
                child: Row(
                  children: [
                    Text(
                      'shipping charges:',
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                    ),
                    Text(
                      '£$_shippingCharges',
                      style: TextStyle(
                          color: accentColor,
                          fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: footerColor,
            thickness: 1,
          ),
          Container(
            child: Column(
              children: [
                for (var item in cart.products)
                  CartItem(
                    image: item.images![0],
                    name: item.name,
                    price: item.productPrice,
                    onDeletePress: () {
                      onDelete!(item.reference!);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final int? quantity;
  final String? image;
  final String? name;
  final double? price;
  final Function()? onDeletePress;
  CartItem(
      {this.quantity, this.image, this.name, this.price, this.onDeletePress});

  @override
  Widget build(BuildContext context) {
    String _image = image ?? '';
    String _name = name ?? '';
    double _price = price ?? 0;
    int _quantity = quantity ?? 0;
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
                child: Image.network(_image),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: TextStyle(
                      fontSize: _name.length >= 20
                          ? SizeConfig.blockSizeHorizontal * 0.5
                          : SizeConfig.blockSizeHorizontal * 1,
                    ),
                  ),
                  Text(
                    '£$_price',
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
                  Row(
                    children: [
                      Text(
                        'Quantity:',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                      ),
                      IconButton(
                        onPressed: () => onDeletePress!(),
                        icon: Icon(
                          FontAwesomeIcons.trashAlt,
                          size: SizeConfig.blockSizeHorizontal * 1,
                          color: Colors.red.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.minusSquare,
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
                            '$_quantity',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                          ),
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.plusSquare,
                        size: SizeConfig.blockSizeHorizontal * 1,
                        color: accentColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SelectAllContainer extends StatelessWidget {
  final int? totalCount;
  SelectAllContainer({this.totalCount});
  @override
  Widget build(BuildContext context) {
    int _totalCount = totalCount ?? 0;
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
                'Shopping Cart($_totalCount)',
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

class CartMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartMobileViewModel>.reactive(
      viewModelBuilder: () => CartMobileViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: accentColor,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: SizeConfig.blockSizeVertical * 10,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 2,
                      vertical: SizeConfig.blockSizeVertical * 0.5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shopping Cart (3)',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            TickBox(onTickChange: (val) {}),
                            Text(
                              'Select All',
                              style: TextStyle(
                                fontFamily: 'Lato',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 20,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 2),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  TickBox(onTickChange: (val) {}),
                                  Text(
                                    'UK Grocery Store',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Shipping Charges : ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '£ 2.00',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.black87,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    TickBox(
                                      onTickChange: (val) {},
                                    ),
                                    Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                              'assets/images/Capture.png'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: SizeConfig.blockSizeHorizontal *
                                            1.75),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hershey\'s Syrup',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    1),
                                        Text(
                                          'GBP £250',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Quantity :',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              SizeConfig.blockSizeVertical * 1),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height:
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                            width:
                                                SizeConfig.blockSizeVertical *
                                                    6,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '1',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2),
                                          Icon(
                                            FontAwesomeIcons.trashAlt,
                                            size: 20,
                                            color: Colors.red,
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
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 33,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 2),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  TickBox(onTickChange: (val) {}),
                                  Text(
                                    'MS Store',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Shipping Charges : ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '£ 1.00',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.black87,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    TickBox(
                                      onTickChange: (val) {},
                                    ),
                                    Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                              'assets/images/suasages.png'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: SizeConfig.blockSizeHorizontal *
                                            1.75),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hershey\'s Syrup',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    1),
                                        Text(
                                          'GBP £250',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Quantity :',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              SizeConfig.blockSizeVertical * 1),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height:
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                            width:
                                                SizeConfig.blockSizeVertical *
                                                    6,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '1',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2),
                                          Icon(
                                            FontAwesomeIcons.trashAlt,
                                            size: 20,
                                            color: Colors.red,
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
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Divider(
                          color: Colors.black87,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    TickBox(
                                      onTickChange: (val) {},
                                    ),
                                    Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                              'assets/images/nutella.png'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: SizeConfig.blockSizeHorizontal *
                                            1.75),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nutella',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    1),
                                        Text(
                                          'GBP £10',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Quantity :',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              SizeConfig.blockSizeVertical * 1),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height:
                                                SizeConfig.blockSizeHorizontal *
                                                    6,
                                            width:
                                                SizeConfig.blockSizeVertical *
                                                    6,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '2',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2),
                                          Icon(
                                            FontAwesomeIcons.trashAlt,
                                            size: 20,
                                            color: Colors.red,
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
