import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Forum/ForumViewModel.dart';
import 'package:main_store/View/Widgets/custom_button.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';

// Complete Forum For the SignUp/Sign In Screen
class Forum extends StatelessWidget {
  final bool? isSignIn;
  final bool? isTablet;
  final Future Function(
    String,
    String,
  )? onSignInClick;
  final Future Function(
    String,
    String,
    String,
    String,
    String,
    String,
    String,
    String,
  )? onClick;
  Forum({this.isSignIn, this.onClick, this.onSignInClick, this.isTablet});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isSignIn = isSignIn ?? false;
    return ViewModelBuilder<ForumViewModel>.reactive(
      viewModelBuilder: () => ForumViewModel(),
      builder: (context, model, child) => Form(
        key: model.formKey,
        autovalidateMode: model.autovalidateMode,
        child: Column(
          children: [
            Container(
              width: isTablet!
                  ? SizeConfig.blockSizeHorizontal * 45
                  : SizeConfig.blockSizeHorizontal * 37,
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
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Container(
                    child: Text(
                      _isSignIn ? 'SIGN IN' : 'SIGN UP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeHorizontal * 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => model.googleSignIn(_isSignIn),
                            child: Image.asset(
                              'assets/images/google.png',
                              height: SizeConfig.blockSizeVertical * 5,
                              width: SizeConfig.blockSizeHorizontal * 5,
                            ),
                          ),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => model.facebookAuth(_isSignIn),
                            child: Image.asset(
                              'assets/images/facebook.png',
                              height: SizeConfig.blockSizeVertical * 5,
                              width: SizeConfig.blockSizeHorizontal * 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Column(
                    children: [
                      !_isSignIn
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeConfig.blockSizeHorizontal * 1.2,
                              ),
                              child: TextInputField(
                                controller: model.usernameController,
                                type: TextInputType.name,
                                onTablet: isTablet,
                                validateForm: (val) =>
                                    model.validateForum(val, 'User Name'),
                                onChange: (val) {
                                  model.name = val;
                                },
                                hint_text: 'User Name',
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      !_isSignIn
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextInputField(
                                controller: model.phoneController,
                                type: TextInputType.phone,
                                onTablet: isTablet,
                                validateForm: (val) =>
                                    model.validateForum(val, 'Phone No'),
                                onChange: (val) {
                                  model.phone = val;
                                },
                                hint_text: 'Phone Number',
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextInputField(
                          controller: model.emailController,
                          onTablet: isTablet,
                          validateForm: (val) => model.validateEmail(val!),
                          onChange: (val) {
                            model.email = val;
                          },
                          hint_text: 'Enter Email',
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextInputField(
                          isObsocured: true,
                          onTablet: isTablet,
                          validateForm: (val) => model.validatePassword(val),
                          onChange: (val) {
                            model.pass = val;
                          },
                          hint_text: 'Password',
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      !_isSignIn
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextInputField(
                                isObsocured: true,
                                onTablet: isTablet,
                                validateForm: (val) =>
                                    model.validateConfirmPass(val),
                                onChange: (val) {
                                  model.confirm_pass = val;
                                },
                                hint_text: 'Confirm Password',
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      !_isSignIn
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 15.2,
                                  child: TextInputField(
                                    type: TextInputType.phone,
                                    onTablet: isTablet,
                                    validateForm: (val) =>
                                        model.validateForum(val, 'city'),
                                    onChange: (val) {
                                      model.city = val;
                                    },
                                    hint_text: 'City',
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeVertical * 1,
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 15.2,
                                  child: TextInputField(
                                    type: TextInputType.phone,
                                    onTablet: isTablet,
                                    validateForm: (val) =>
                                        model.validateForum(val, 'Postal Code'),
                                    onChange: (val) {
                                      model.postal_code = val;
                                    },
                                    hint_text: 'Postal Code',
                                  ),
                                )
                              ],
                            )
                          : Container(),
                      !_isSignIn
                          ? SizedBox(
                              height: SizeConfig.blockSizeVertical * 1.5,
                            )
                          : Container(),
                      !_isSignIn
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextInputField(
                                onTablet: isTablet,
                                validateForm: (val) =>
                                    model.validateForum(val, 'Address'),
                                onChange: (val) {
                                  model.address = val;
                                },
                                hint_text: 'Address',
                              ),
                            )
                          : Container(),
                      !_isSignIn
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: 8.0,
                                  left: SizeConfig.blockSizeHorizontal * 2.5),
                              child: Row(
                                children: [
                                  Checkbox(
                                    side: BorderSide(width: 1),
                                    value: model.isTicked,
                                    onChanged: (val) {
                                      model.checkTick();
                                    },
                                    activeColor: accentColor,
                                  ),
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 15,
                                    height: isTablet!
                                        ? SizeConfig.blockSizeHorizontal * 2
                                        : SizeConfig.blockSizeVertical * 3.5,
                                    child: Text(
                                      agreeing_term_text,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                0.7,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(
                                  left: isTablet!
                                      ? SizeConfig.blockSizeHorizontal * 3.5
                                      : SizeConfig.blockSizeHorizontal * 2),
                              child: ForgetPasswordPage(
                                  onTap: () =>
                                      model.navigateToForgotPasswordPage()),
                            ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1,
                        ),
                        child: CustomButton(
                          onTablet: isTablet,
                          isLoading: model.isLoading,
                          onPressed: _isSignIn
                              ? () {
                                  var result = model.validateInputs();
                                  if (result == 1) {
                                    model.isBusy(true);
                                    onSignInClick!(model.email, model.pass)
                                        .then((value) => model.isBusy(false));
                                  }
                                }
                              : () {
                                  var result = model.validateInputs();
                                  if (result == 1) {
                                    model.isBusy(true);
                                    onClick!(
                                            model.email,
                                            model.pass,
                                            model.name,
                                            model.phone,
                                            model.confirm_pass,
                                            model.address,
                                            model.city,
                                            model.postal_code)
                                        .then((value) => model.isBusy(false));
                                  }
                                },
                          label: _isSignIn ? 'SIGN IN' : 'SIGN UP',
                          isEnable: _isSignIn ? true : model.isTicked,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      _isSignIn
                          ? Container(
                              padding: EdgeInsets.only(
                                  left: isTablet!
                                      ? SizeConfig.blockSizeHorizontal * 3.5
                                      : SizeConfig.blockSizeHorizontal * 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have and Account '),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () => model.navigateToSignUp(),
                                      child: Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                            color: accentColor,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgetPasswordPage extends StatelessWidget {
  final Function? onTap;
  ForgetPasswordPage({this.onTap});
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap!(),
        child: Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Forget Password?',
            style: TextStyle(
              color: accentColor,
              fontSize: SizeConfig.blockSizeHorizontal * 1,
            ),
          ),
        ),
      ),
    );
  }
}
