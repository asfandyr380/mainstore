import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/Models/SummeryModel.dart';
import 'package:main_store/View/Widgets/orderSummery/summeryViewModel.dart';
import 'package:stacked/stacked.dart';

import '../custom_button.dart';

class OrderSummary extends StatelessWidget {
  final double? subTotal;
  final double? shippingfee;
  final double? total;
  final bool? checkout;
  final SummeryModel? m;
  final Function? pay;
  final bool? isLoading;
  OrderSummary({
    this.checkout,
    this.shippingfee,
    this.subTotal,
    this.total,
    this.m,
    this.pay,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    bool _checkout = checkout ?? false;
    double _subTotal = subTotal ?? 0;
    double _shippingfee = shippingfee ?? 0;
    double _total = total ?? 0;
    bool _isLoading = isLoading ?? false;
    return ViewModelBuilder<SummeryViewModel>.reactive(
      viewModelBuilder: () => SummeryViewModel(),
      builder: (context, model, child) => Container(
        // height: SizeConfig.blockSizeVertical * 48,
        width: SizeConfig.blockSizeHorizontal * 22,
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
              vertical: SizeConfig.blockSizeVertical * 1,
              horizontal: SizeConfig.blockSizeHorizontal * 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Summary',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeHorizontal * 2),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sub Total',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.blockSizeHorizontal * 1),
                  ),
                  Text(
                    _checkout
                        ? '£ ${_subTotal.toStringAsFixed(2)}'
                        : '${m!.subtotal!.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.blockSizeHorizontal * 1),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 0.8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.blockSizeHorizontal * 1),
                  ),
                  Text(
                    _checkout
                        ? '£ ${_shippingfee.toStringAsFixed(2)}'
                        : '${m!.shipping!.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.blockSizeHorizontal * 1),
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
                        fontSize: SizeConfig.blockSizeHorizontal * 2),
                  ),
                  Text(
                    _checkout
                        ? '£ ${_total.toStringAsFixed(2)}'
                        : '${m!.total!.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeHorizontal * 2),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              _checkout
                  ? Container()
                  : Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Payment Method:',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.blockSizeHorizontal * 1),
                      ),
                    ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              _checkout
                  ? Container()
                  : Row(
                      children: [
                        Checkbox(
                          side: BorderSide(width: 1),
                          value: model.isChecked,
                          onChanged: (val) => model.changeState(val),
                          activeColor: accentColor,
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 6,
                          child: Image.asset('assets/images/paypal-logo.png'),
                        ),
                      ],
                    ),
              _checkout
                  ? Container()
                  : SizedBox(
                      height: SizeConfig.blockSizeVertical * 3,
                    ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 20,
                child: CustomButton(
                  isLoading: _isLoading,
                  isEnable: _checkout ? true : model.isChecked,
                  onPressed: () => _checkout
                      ? model.navigateToCheckOut(
                          _total, _subTotal, _shippingfee)
                      : pay!(),
                  label: _checkout ? 'Check Out' : 'Proceed To Pay',
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
