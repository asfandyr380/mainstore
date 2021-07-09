import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageView.dart';
import 'package:main_store/View/Widgets/orderSummery/order_summary.dart';
import 'package:main_store/View/Widgets/responsive.dart';
import 'package:stacked/stacked.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'CartViewModel.dart';

class TickBox extends StatelessWidget {
  final Function(bool?) onTickChange;
  final bool? value;
  TickBox({required this.onTickChange, this.value});

  @override
  Widget build(BuildContext context) {
    bool _value = value ?? false;
    return Checkbox(
      side: BorderSide(width: 0.5),
      value: _value,
      onChanged: (val) => onTickChange(val),
      activeColor: accentColor,
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: LandingPage(
          index: 2,
        ),
        tablet: CartViewPage(),
        desktop: CartViewPage());
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
      onModelReady: (model) => model.getcart(),
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
                          child: SelectAllContainer(
                            totalCount: model.itemCount,
                            selected: model.selected,
                            isSelected: (val) => model.selectall(val),
                          ),
                        ),
                        model.isLoading
                            ? Container(
                                width: SizeConfig.blockSizeHorizontal * 30,
                                child: LinearProgressIndicator(
                                  color: accentColor,
                                  backgroundColor: accentColor.withOpacity(0.5),
                                ),
                              )
                            : SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                        for (var cart in model.cartlist)
                          if (cart.product.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 2,
                              ),
                              child: CartitemsContainer(
                                cart: cart,
                                selected: cart.isSelected,
                                onSelect: (val, cart) =>
                                    model.onSelect(val, cart),
                                nestedSelectAll: (val) =>
                                    model.nestedSelectall(val, cart),
                                onDelete: (id, store) =>
                                    model.removeProductFromCart(id).then(
                                  (e) {
                                    if (e)
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.error(
                                          icon: Icon(Icons.delete_forever,
                                              size: 120,
                                              color: Color(352321536)),
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
                      isEnable: model.cartlist.isEmpty ? false : true,
                      subTotal: model.subTotal,
                      total: model.total,
                      shippingfee: model.shipping,
                      checkout: true,
                    ),
                  ],
                ),
              ),
              model.cartlist.isEmpty
                  ? SizedBox(
                      height: SizeConfig.blockSizeVertical * 12,
                    )
                  : Container(),
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
  final Function(int, String)? onDelete;
  final Function(bool, int)? addorPlus;
  final bool? selected;
  final Function(bool)? nestedSelectAll;
  final Function(bool, CartProducts)? onSelect;
  CartitemsContainer({
    required this.cart,
    this.onDelete,
    this.addorPlus,
    this.selected,
    this.nestedSelectAll,
    this.onSelect,
  });
  @override
  Widget build(BuildContext context) {
    double _shippingCharges = 0;
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
                  TickBox(
                    onTickChange: (val) => nestedSelectAll!(val!),
                    value: selected,
                  ),
                  Text(
                    cart.storeName,
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
                for (var item in cart.product)
                  if (cart.product.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1),
                      child: CartItem(
                        onSelect: (val) => onSelect!(val, item),
                        nestedSelect: item.isSelected,
                        image: item.products!.images![0],
                        name: item.products!.name,
                        price: item.products!.attributePrice == 0
                            ? item.products!.productPrice
                            : item.products!.attributePrice,
                        quantity: item.quantity,
                        onDeletePress: () {
                          onDelete!(item.cartId, cart.storeName);
                        },
                      ),
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
  final bool? nestedSelect;
  final Function(bool)? onSelect;
  CartItem({
    this.quantity,
    this.image,
    this.name,
    this.price,
    this.onDeletePress,
    this.nestedSelect,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    String _image = image ?? '';
    String _name = name ?? '';
    double _price = price ?? 0;
    int _quantity = quantity ?? 0;
    SizeConfig().init(context);
    return Stack(
      children: [
        Container(
          height: SizeConfig.blockSizeVertical * 12,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 1,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: TickBox(
                  onTickChange: (val) => onSelect!(val!),
                  value: nestedSelect,
                ),
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 8,
                width: SizeConfig.blockSizeHorizontal * 5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_image),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _name,
                    style: TextStyle(
                      fontSize: _name.length >= 20
                          ? SizeConfig.blockSizeHorizontal * 0.5
                          : SizeConfig.blockSizeHorizontal * 1,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 0.5,
                  ),
                  Text(
                    '£$_price',
                    style: TextStyle(
                        color: accentColor,
                        fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                  )
                ],
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 0.5,
              ),
              Container(
                child: QuantityColumn(
                  quantity: _quantity,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 1),
          child: IconButton(
            onPressed: () => onDeletePress!(),
            icon: Icon(
              FontAwesomeIcons.trashAlt,
              size: SizeConfig.blockSizeHorizontal * 1,
              color: Colors.red.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}

class QuantityColumn extends StatefulWidget {
  final int? quantity;
  const QuantityColumn({this.quantity});

  @override
  _QuantityColumnState createState() => _QuantityColumnState();
}

class _QuantityColumnState extends State<QuantityColumn> {
  int q = 0;

  addOrMiuns(
    bool adding,
  ) {
    if (adding) {
      setState(() {
        q++;
      });
    } else {
      if (q <= 1) {
        setState(() {
          q = 1;
        });
      } else
        setState(() {
          q--;
        });
    }
  }

  @override
  void initState() {
    super.initState();
    q = widget.quantity!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text(
            'Quantity:',
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 0.7),
          ),
        ),
        Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                onPressed: () => addOrMiuns(false),
                icon: Icon(
                  FontAwesomeIcons.minusSquare,
                  size: SizeConfig.blockSizeHorizontal * 1,
                ),
                color: accentColor,
              ),
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
                  '${q}',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                onPressed: () => addOrMiuns(true),
                icon: Icon(
                  FontAwesomeIcons.plusSquare,
                  size: SizeConfig.blockSizeHorizontal * 1,
                ),
                color: accentColor,
              ),
            )
          ],
        )
      ],
    );
  }
}

class SelectAllContainer extends StatelessWidget {
  final int? totalCount;
  final bool? selected;
  final Function(bool)? isSelected;
  SelectAllContainer({this.totalCount, this.selected, this.isSelected});
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
                  TickBox(
                    value: selected!,
                    onTickChange: (val) => isSelected!(val!),
                  ),
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Title
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
                //CheckOut Button
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Check Out',
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: accentColor,
                        ),
                      ),
                    ],
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
