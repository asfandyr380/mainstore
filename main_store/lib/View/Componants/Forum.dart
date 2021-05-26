import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Widgets/custom_button.dart';
import 'package:main_store/View/Widgets/text_field.dart';

// Complete Forum For the SignUp/Sign In Screen
class Forum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Container(
          height: SizeConfig.blockSizeVertical * 70,
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
                  'SIGN UP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextInputField(
                      hint_text: 'User Name',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextInputField(
                      hint_text: 'Phone Number',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextInputField(hint_text: 'Enter Email'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextInputField(hint_text: 'Password'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextInputField(hint_text: 'Confirm Password'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, left: SizeConfig.blockSizeHorizontal * 2),
                    child: Row(
                      children: [
                        Checkbox(value: false, onChanged: (val) {}),
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
                      onPressed: () {},
                      label: 'SIGN UP',
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
