import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Widgets/custom_button.dart';
import 'package:main_store/View/Widgets/order_summary.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';
import 'CheckOutViewModel.dart';

class CheckOutPage extends StatefulWidget {
  final bool? checkout;
  CheckOutPage({this.checkout});

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
                                  child:
                                      TextInputField(hint_text: 'First Name'),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 20,
                                  child: TextInputField(hint_text: 'Last Name'),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 42,
                                child: TextInputField(hint_text: 'Address'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 42,
                                child: TextInputField(
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
                                child: TextInputField(hint_text: 'City'),
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
                                      hint_text: 'Country/Region'),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 20,
                                  child:
                                      TextInputField(hint_text: 'Postal Code'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //checkout Order Summary
                    OrderSummary(
                      checkout: _checkout,
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
