import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/SummeryModel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Widgets/orderSummery/order_summary.dart';
import 'package:main_store/View/Widgets/responsive.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';
import 'CheckOutViewModel.dart';

class CheckoutPage extends StatelessWidget {
  final bool? checkout;
  final SummeryModel? m;
  const CheckoutPage({this.checkout, this.m});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: CheckOutMobile(
          details: m,
        ),
        tablet: CheckOutPage(
          m: m,
        ),
        desktop: CheckOutPage(
          m: m,
        ));
  }
}

class CheckOutPage extends StatefulWidget {
  final bool? checkout;
  final SummeryModel? m;
  CheckOutPage({this.checkout, this.m});

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _checkout = widget.checkout ?? false;
    return ViewModelBuilder<CheckOutViewModel>.reactive(
      viewModelBuilder: () => CheckOutViewModel(),
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
                    //checkout contact INFO
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2.5,
                      ),
                      height: _checkout
                          ? SizeConfig.blockSizeVertical * 40
                          : SizeConfig.blockSizeVertical * 80,
                      width: SizeConfig.blockSizeHorizontal * 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Contact Information',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 2),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Already have account?',
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                0.8,
                                      ),
                                    ),
                                    Text(
                                      ' Log in',
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                0.8,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 42,
                                child: TextInputField(
                                    onChange: (val) {
                                      model.phone = val;
                                    },
                                    hint_text: 'Enter Phone Number'),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeHorizontal * 1),
                            child: Row(
                              children: [
                                Text(
                                  'Shipping Information',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.blockSizeHorizontal * 1.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 20,
                                  child: TextInputField(
                                      onChange: (val) {
                                        model.firstName = val;
                                      },
                                      hint_text: 'First Name'),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 20,
                                  child: TextInputField(
                                      onChange: (val) {
                                        model.lastName = val;
                                      },
                                      hint_text: 'Last Name'),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 42,
                                child: TextInputField(
                                    onChange: (val) {
                                      model.address = val;
                                    },
                                    hint_text: 'Address'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 42,
                                child: TextInputField(
                                    onChange: (val) {
                                      model.apartment = val;
                                    },
                                    hint_text:
                                        'Apartment, Suit, etc(Optional)'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 42,
                                child: TextInputField(
                                    onChange: (val) {
                                      model.city = val;
                                    },
                                    hint_text: 'City'),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.blockSizeHorizontal * 1.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 20,
                                  child: TextInputField(
                                      onChange: (val) {
                                        model.country = val;
                                      },
                                      hint_text: 'Country/Region'),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 20,
                                  child: TextInputField(
                                      onChange: (val) {
                                        model.postalCode = val;
                                      },
                                      hint_text: 'Postal Code'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //checkout Order Summary
                    OrderSummary(
                      isLoading: model.isLoading,
                      checkout: _checkout,
                      m: widget.m,
                      pay: () => model.checkout(widget.m!, widget.m!.ids),
                    ),
                  ],
                ),
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckOutMobile extends StatelessWidget {
  final SummeryModel? details;
  CheckOutMobile({this.details});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _total = details!.total!;
    double _subtotal = details!.subtotal!;
    double _shipping = details!.shipping!;
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: accentColor,
              ),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      child: Center(
                        child: Text(
                          'Check Out',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2,
                          left: SizeConfig.blockSizeHorizontal * 4),
                      child: Text(
                        'Contact Information',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 4),
                      child: TextInputField(
                        hint_text: 'Enter Phone Number',
                        onMobile: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1.5,
                          left: SizeConfig.blockSizeHorizontal * 4),
                      child: Text(
                        'Shipping Information',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: SizeConfig.blockSizeVertical * 5,
                            width: SizeConfig.blockSizeHorizontal * 45,
                            child: TextInputField(
                              hint_text: 'First Name',
                              onMobile: true,
                            ),
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 5,
                            width: SizeConfig.blockSizeHorizontal * 45,
                            child: TextInputField(
                              hint_text: 'Last Name',
                              onMobile: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 4),
                      child: TextInputField(
                        hint_text: 'Address',
                        onMobile: true,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 4),
                      child: TextInputField(
                        hint_text: 'Apartment, Suite, etc. (Optional)',
                        onMobile: true,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 4),
                      child: TextInputField(
                        hint_text: 'City',
                        onMobile: true,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: SizeConfig.blockSizeVertical * 5,
                            width: SizeConfig.blockSizeHorizontal * 45,
                            child: TextInputField(
                              //todo: Dropdown menu will come here
                              hint_text: 'Country / Region',
                              onMobile: true,
                            ),
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 5,
                            width: SizeConfig.blockSizeHorizontal * 45,
                            child: TextInputField(
                              hint_text: 'Postal Code',
                              onMobile: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2,
                          left: SizeConfig.blockSizeHorizontal * 4),
                      child: Text(
                        'Cart Summary',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1,
                          left: SizeConfig.blockSizeHorizontal * 4),
                      child: Text(
                        'Subtotal : £$_subtotal',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1,
                          left: SizeConfig.blockSizeHorizontal * 4),
                      child: Text(
                        'Shipping : £$_shipping',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1,
                          left: SizeConfig.blockSizeHorizontal * 4),
                      child: Text(
                        'Total : £$_total',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1.5,
                          left: SizeConfig.blockSizeHorizontal * 4),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Proceed to Pay',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => CheckOutViewModel());
  }
}
