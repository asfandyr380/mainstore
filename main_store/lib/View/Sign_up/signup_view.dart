import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Forum/Forum.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageView.dart';
import 'package:main_store/View/Sign_up/signup_viewmodel.dart';
import 'package:main_store/View/Widgets/responsive.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: LandingPage(
          index: 3,
          onSignUp: true,
        ),
        tablet: SignupPage(),
        desktop: SignupPage());
  }
}

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                  )
                ]),
                child: Header(),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Forum(
                  onClick: (email, pass, name, phone) =>
                      model.signUp(name, email, phone, pass),
                ),
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpMobile extends StatelessWidget {
  String _username = '';
  String _phone = '';
  String _email = '';
  String _password = '';
  String _confirmPass = '';
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, model, child) => Scaffold(
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
                  onChange: (val) => {_username = val},
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
                  onChange: (val) => {_phone = val},
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
                  onChange: (val) => {_email = val},
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
                  onChange: (val) => {_password = val},
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
                  onChange: (val) {
                    _confirmPass = val;
                  },
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
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
                  child: Checkbox(
                    value: model.isCheck,
                    activeColor: accentColor,
                    onChanged: (val) => model.accepttermsandCondition(val!),
                  ),
                ),
                Text(
                  'By creating an account, you agree to \nour Free Membership Agreement and ',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1.67),
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
              onPressed: model.isCheck
                  ? () => model.signUp(_username, _email, _phone, _password)
                  : null,
              child: model.isLoading
                  ? Container(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Sign Up',
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
    );
  }
}
