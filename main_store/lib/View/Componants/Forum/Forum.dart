import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Forum/ForumViewModel.dart';
import 'package:main_store/View/Widgets/custom_button.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';

String name = '';
String email = '';
String pass = '';
String confirm_pass = '';
String phone = '';

// Complete Forum For the SignUp/Sign In Screen
class Forum extends StatelessWidget {
  final bool? isSignIn;
  final Function(
    String email,
    String pass,
    String name,
    String phone,
  ) onClick;
  Forum({this.isSignIn, required this.onClick});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _isSignIn = isSignIn ?? false;
    return ViewModelBuilder.reactive(
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
                                name = val;
                                print(name);
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
                                phone = val;
                                print(phone);
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
                          email = val;
                          print(email);
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
                          pass = val;
                          print(pass);
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
                                confirm_pass = val;
                                print(confirm_pass);
                              },
                              hint_text: 'Confirm Password',
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: SizeConfig.blockSizeHorizontal * 2),
                      child: Row(
                        children: [
                          Checkbox(
                            side: BorderSide(width: 1),
                            value: false,
                            onChanged: (val) {},
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
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 7),
                      child: CustomButton(
                        onPressed: onClick(email, pass, name, phone),
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
