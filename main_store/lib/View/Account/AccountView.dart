import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Account/AccountViewModel.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: accentColor,
              ),
              body: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 5,
                      ),
                      child: Container(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 4),
                    child: Container(
                      child: TextInputField(
                        hint_text: 'Username',
                        onMobile: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 4),
                    child: Container(
                      child: TextInputField(
                        hint_text: 'Phone Number',
                        onMobile: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 4),
                    child: Container(
                      child: TextInputField(
                        hint_text: 'Enter Email',
                        onMobile: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 4),
                    child: Container(
                      child: TextInputField(
                        hint_text: 'Enter Password',
                        onMobile: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2.5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 4),
                    child: Container(
                      child: TextInputField(
                        hint_text: 'Confirm Password',
                        onMobile: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 1),
                        child: Checkbox(value: false, onChanged: null),
                      ),
                      Text(
                        'By creating an account, you agree to \nour Free Membership Agreement and ',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1.67),
                        child: Text(
                          'Privacy Policy.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Lato',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: accentColor,
                      fixedSize: Size(SizeConfig.blockSizeHorizontal * 90,
                          SizeConfig.blockSizeVertical * 5),
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => AccountViewModel());
  }
}
