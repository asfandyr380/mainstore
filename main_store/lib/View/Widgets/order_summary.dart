import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

import 'custom_button.dart';

class OrderSummary extends StatelessWidget {
  OrderSummary({
    this.isPayOut,
    required this.labelbutton,
    required bool checkout,
  }) : _checkout = checkout;

  final bool _checkout;
  final String labelbutton;
  final bool? isPayOut;
  @override
  Widget build(BuildContext context) {
    bool _isPayOut = isPayOut ?? false;
    return Container(
      height: _checkout
          ? SizeConfig.blockSizeVertical * 30
          : SizeConfig.blockSizeVertical * 40,
      width: SizeConfig.blockSizeHorizontal * 18,
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
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(
                  'Order Summary',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 3.5),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub Total',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
                Text(
                  '\$ 150.00',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
                Text(
                  '\$ 300',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 3.5),
                ),
                Text(
                  '\$ 170',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 3.5),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Select Payment Method:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  side: BorderSide(width: 1),
                  value: false,
                  onChanged: (val) {},
                  activeColor: accentColor,
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 4,
                  child: Image.asset('assets/images/paypal-logo.png'),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: SizeConfig.blockSizeHorizontal * 16,
                  child: CustomButton(
                    onPressed: () {},
                    label: _isPayOut ? 'Proceed to Pay' : 'Check Out',
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
