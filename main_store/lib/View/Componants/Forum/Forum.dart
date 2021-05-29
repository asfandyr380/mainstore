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
  final Function(
    String,
    String,
    String,
    String,
  ) onClick;
  Forum({this.isSignIn, required this.onClick});
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
            width: SizeConfig.blockSizeHorizontal * 35,
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                ),
                Column(
                  children: [
                    !_isSignIn
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextInputField(
                              onChange: (val) {
                                model.name = val;
                              },
                              hint_text: 'User Name',
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    !_isSignIn
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextInputField(
                              onChange: (val) {
                                model.phone = val;
                              },
                              hint_text: 'Phone Number',
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextInputField(
                        onChange: (val) {
                          model.email = val;
                        },
                        hint_text: 'Enter Email',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextInputField(
                        onChange: (val) {
                          model.pass = val;
                        },
                        hint_text: 'Password',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    !_isSignIn
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextInputField(
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
                                  child: Expanded(
                                    child: Text(
                                      agreeing_term_text,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 2),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(color: accentColor),
                            ),
                          ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 7),
                      child: CustomButton(
                        isEnable: _isSignIn ? true : model.isTicked,
                        onPressed: () => onClick(
                            model.email, model.pass, model.name, model.phone),
                        label: 'SIGN UP',
                      ),
                    )
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
