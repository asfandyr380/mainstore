import 'package:flutter/material.dart';
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
  )? onClick;
  Forum({this.isSignIn, this.onClick, this.onSignInClick, this.isTablet});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isSignIn = isSignIn ?? false;
    return ViewModelBuilder<ForumViewModel>.reactive(
      viewModelBuilder: () => ForumViewModel(),
      builder: (context, model, child) => Column(
        children: [
          Container(
            height: _isSignIn
                ? SizeConfig.blockSizeVertical * 50
                : SizeConfig.blockSizeVertical * 70,
            width: isTablet!
                ? SizeConfig.blockSizeHorizontal * 45
                : SizeConfig.blockSizeHorizontal * 35,
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
                Container(
                  child: Text(
                    _isSignIn ? 'SIGN IN' : 'SIGN UP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeHorizontal * 2,
                    ),
                  ),
                ),
                Column(
                  children: [
                    !_isSignIn
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeHorizontal * 1.2,
                            ),
                            child: TextInputField(
                              type: TextInputType.name,
                              onTablet: isTablet,
                              validateForm: (val) => model.validateForum(val),
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
                              type: TextInputType.phone,
                              onTablet: isTablet,
                              validateForm: (val) => model.validateForum(val),
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
                        onTablet: isTablet,
                        validateForm: (val) => model.validateForum(val),
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
                        validateForm: (val) => model.validateForum(val),
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
                              validateForm: (val) => model.validateForum(val),
                              onChange: (val) {
                                model.confirm_pass = val;
                              },
                              hint_text: 'Confirm Password',
                            ),
                          )
                        : Container(),
                    !_isSignIn
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: 8.0,
                                left: SizeConfig.blockSizeHorizontal * 2),
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
                                          SizeConfig.blockSizeHorizontal * 0.7,
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
                            child: ForgetPasswordPage(),
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
                                  model.isBusy(true);
                                  onSignInClick!(model.email, model.pass)
                                      .then((value) => model.isBusy(false));
                                }
                              : () {
                                  model.isBusy(true);
                                  onClick!(model.email, model.pass, model.name,
                                          model.phone, model.confirm_pass)
                                      .then((value) => model.isBusy(false));
                                },
                          label: _isSignIn ? 'SIGN IN' : 'SIGN UP',
                          isEnable: _isSignIn ? true : model.isTicked,
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
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
    );
  }
}
