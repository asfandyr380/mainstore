import 'dart:async';

import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/AccountVerification/AccountVerificationModel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:stacked/stacked.dart';

class AccountVerificationView extends StatelessWidget {
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: accentColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<AccountVerificationViewModel>.reactive(
        viewModelBuilder: () => AccountVerificationViewModel(),
        builder: (ctx, model, child) => Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2,
                      )
                    ]),
                    child: Header(
                      isSignInPage: true,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: SizeConfig.blockSizeHorizontal * 37,
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
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            'Verify Your Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeHorizontal * 2,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1.5,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: PinPut(
                              fieldsCount: 4,
                              onChanged: (val) {
                                model.pin = val;
                              },
                              focusNode: model.pinPutFocusNode,
                              controller: model.controller,
                              submittedFieldDecoration:
                                  _pinPutDecoration.copyWith(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              followingFieldDecoration:
                                  _pinPutDecoration.copyWith(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color: footerColor,
                                ),
                              ),
                              selectedFieldDecoration: _pinPutDecoration,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1.5,
                          ),
                          ElevatedButton(
                            onPressed: () => model.checkCode(),
                            style: ElevatedButton.styleFrom(
                              primary: accentColor,
                              fixedSize:
                                  Size(SizeConfig.blockSizeHorizontal * 10, 10),
                            ),
                            child: model.isLoading
                                ? Container(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text('Verify'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Footer(),
                  )
                ],
              ),
            ));
  }
}
