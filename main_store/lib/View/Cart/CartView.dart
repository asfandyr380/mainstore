import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Componants/Header/header_view.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/CartModel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
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
                child: Header(type: HeaderViewType.searchable),
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
                            isSelected: (val) => model.selectAll(val),
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
                                addorPlus: (val, cart) =>
                                    model.addorPlus(val, cart),
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
                      selectedProducts: model.selectedProducts,
                      ids: model.ids,
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
  final bool? selected;
  final Function(bool)? nestedSelectAll;
  final Function(bool, CartProducts)? onSelect;
  final Function(bool, CartProducts)? addorPlus;
  CartitemsContainer({
    required this.cart,
    this.onDelete,
    this.selected,
    this.nestedSelectAll,
    this.onSelect,
    this.addorPlus,
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
                    value: cart.isSelected,
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
                          fontSize: SizeConfig.blockSizeHorizontal * 1),
                    ),
                    Text(
                      ' ??$_shippingCharges',
                      style: TextStyle(
                          color: accentColor,
                          fontSize: SizeConfig.blockSizeHorizontal * 1),
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
                        addorPlus: (val) => addorPlus!(val, item),
                        onSelect: (val) => onSelect!(val, item),
                        nestedSelect: item.isSelected,
                        image: item.products!.images![0],
                        name: item.products!.name,
                        price: item.products!.attributePrice == 0
                            ? item.products!.productPrice
                            : item.products!.attributePrice!.toDouble(),
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
  final Function(bool)? addorPlus;
  CartItem({
    this.quantity,
    this.image,
    this.name,
    this.price,
    this.onDeletePress,
    this.nestedSelect,
    this.onSelect,
    this.addorPlus,
  });

  @override
  Widget build(BuildContext context) {
    String _image = image ?? '';
    String _name = name ?? '';
    double _price = price! * quantity!;
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
                          : SizeConfig.blockSizeHorizontal * 1.1,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 0.5,
                  ),
                  Text(
                    '??$_price',
                    style: TextStyle(
                        color: accentColor,
                        fontSize: SizeConfig.blockSizeHorizontal * 1),
                  )
                ],
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 0.5,
              ),
              Container(
                child: QuantityColumn(
                  addOrMinus: (val) => addorPlus!(val),
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
  final Function(bool)? addOrMinus;
  const QuantityColumn({this.quantity, this.addOrMinus});

  @override
  _QuantityColumnState createState() => _QuantityColumnState();
}

class _QuantityColumnState extends State<QuantityColumn> {
  @override
  Widget build(BuildContext context) {
    int _q = widget.quantity ?? 1;
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
                onPressed: () => widget.addOrMinus!(false),
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
                  '$_q',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 0.7),
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                onPressed: () => widget.addOrMinus!(true),
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
          children: [
            Container(
              alignment: Alignment.centerLeft,
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
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => CartViewModel(),
      onModelReady: (model) => model.getcart(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4,
                vertical: SizeConfig.blockSizeVertical * 4),
            child: Column(
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
                          'Shopping Cart (${model.itemCount})',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            TickBox(
                                value: model.selected,
                                onTickChange: (val) => model.selectAll(val!)),
                            Text(
                              'Select All',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                model.isLoading
                    ? Container(
                        width: SizeConfig.blockSizeHorizontal * 90,
                        child: LinearProgressIndicator(
                          color: accentColor,
                          backgroundColor: accentColor.withOpacity(0.5),
                        ),
                      )
                    : SizedBox(height: SizeConfig.blockSizeVertical * 2),
                for (var cart in model.cartlist)
                  Container(
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                    child: CartItemContainerMobile(
                      cart: cart,
                      selected: cart.isSelected,
                      onSelect: (val, cart) => model.onSelect(val, cart),
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
                                    size: 120, color: Color(352321536)),
                                message: 'Product Removed from Cart',
                              ),
                              displayDuration: Duration(milliseconds: 150),
                            );
                        },
                      ),
                    ),
                  ),
                //CheckOut Button
                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => model.navigateToCheckOut(
                            model.total, model.subTotal, model.shipping),
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

class CartItemContainerMobile extends StatelessWidget {
  final CartModel cart;
  final Function(int, String)? onDelete;
  final Function(bool, int)? addorPlus;
  final bool? selected;
  final Function(bool)? nestedSelectAll;
  final Function(bool, CartProducts)? onSelect;
  CartItemContainerMobile(
      {this.addorPlus,
      required this.cart,
      this.nestedSelectAll,
      this.onDelete,
      this.onSelect,
      this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      TickBox(
                          value: selected,
                          onTickChange: (val) => nestedSelectAll!(val!)),
                      Text(
                        '${cart.storeName}',
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
                        '?? 2.00',
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
            for (var item in cart.product)
              Container(
                padding:
                    EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
                child: CartItems(
                  onSelect: (val) => onSelect!(val, item),
                  nestedSelect: item.isSelected,
                  image: item.products!.images![0],
                  name: item.products!.name,
                  price: item.products!.attributePrice == 0
                      ? item.products!.productPrice
                      : item.products!.attributePrice!.toDouble(),
                  quantity: item.quantity,
                  onDeletePress: () {
                    onDelete!(item.cartId, cart.storeName);
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

class CartItems extends StatelessWidget {
  final int? quantity;
  final String? image;
  final String? name;
  final double? price;
  final Function()? onDeletePress;
  final bool? nestedSelect;
  final Function(bool)? onSelect;
  CartItems({
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
    int _quantity = quantity ?? 1;
    String _image = image ?? '';
    String _name = name ?? '';
    double _price = price ?? 0;
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                TickBox(
                    value: nestedSelect,
                    onTickChange: (val) => onSelect!(val!)),
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(_image),
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 1.75),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_name',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1),
                    Text(
                      '?? $_price',
                      style: TextStyle(
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
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: SizeConfig.blockSizeHorizontal * 6,
                        width: SizeConfig.blockSizeVertical * 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$_quantity',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                      IconButton(
                        onPressed: () => onDeletePress!(),
                        icon: Icon(
                          FontAwesomeIcons.trashAlt,
                          size: 20,
                          color: Colors.red,
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
    );
  }
}
