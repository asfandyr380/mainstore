import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/ForgotPassword/forgotPassviewModel.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      builder: (ctx, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: model.formKey,
            autovalidateMode: model.autovalidateMode,
            child: Column(
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
                          'Forgot Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeHorizontal * 2,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        TextInputField(
                          type: TextInputType.emailAddress,
                          validateForm: (val) => model.validateEmail(val!),
                          onChange: (val) {
                            model.email = val;
                          },
                          hint_text: 'Enter Your Email Address',
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        TextInputField(
                          type: TextInputType.visiblePassword,
                          validateForm: (val) => model.validatePassword(val),
                          onChange: (val) {
                            model.oldPass = val;
                          },
                          hint_text: 'Old Password',
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        TextInputField(
                          type: TextInputType.visiblePassword,
                          validateForm: (val) => model.validatePassword(val),
                          onChange: (val) {
                            model.newPass = val;
                          },
                          hint_text: 'New Password',
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        TextInputField(
                          type: TextInputType.visiblePassword,
                          validateForm: (val) => model.validateConfirmPass(val),
                          onChange: (val) {
                            model.confirmPass = val;
                          },
                          hint_text: 'Confirm Password',
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        ElevatedButton(
                          onPressed: () => model.submit().then((r) {
                            if (r) {
                              model.redirectBack();
                            }
                          }),
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
                              : Text('Change Password'),
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
          ),
        ),
      ),
    );
  }
}
