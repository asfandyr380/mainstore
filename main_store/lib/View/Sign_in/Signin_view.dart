import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Forum/Forum.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/LandingPage_Mobile/LandingPageView.dart';
import 'package:main_store/View/Sign_in/signin_viewModel.dart';
import 'package:main_store/View/Widgets/custom_button.dart';
import 'package:main_store/View/Widgets/responsive.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: LandingPage(
          index: 3,
          onSignIn: true,
        ),
        tablet: SignInWeb(
          onTablet: true,
        ),
        desktop: SignInWeb());
  }
}

class SignInWeb extends StatefulWidget {
  final bool? onTablet;
  SignInWeb({this.onTablet});
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInWeb> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _onTablet = widget.onTablet ?? false;
    return ViewModelBuilder<SigninViewModel>.reactive(
      viewModelBuilder: () => SigninViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 4),
                child: Forum(
                  isTablet: _onTablet,
                  isSignIn: true,
                  onSignInClick: (email, pass) => model.logInUser(email, pass),
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
    );
  }
}

// MOBILE VIEW OF LOGIN
class SignInMobileView extends StatefulWidget {
  SignInMobileView({Key? key}) : super(key: key);

  @override
  _SignInMobileViewState createState() => _SignInMobileViewState();
}

class _SignInMobileViewState extends State<SignInMobileView> {
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SigninViewModel>.reactive(
      viewModelBuilder: () => SigninViewModel(),
      builder: (context, model, child) => Scaffold(
        drawer: Drawer(
          elevation: 16,
          // Drawer content to be added
          child: Center(
            child: Text('No Data'),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 90,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextInputField(
                    onChange: (val) {
                      _email = val;
                    },
                    hint_text: 'Email',
                    onMobile: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 90,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextInputField(
                    onChange: (val) {
                      _password = val;
                    },
                    hint_text: 'Password',
                    onMobile: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: accentColor,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 50,
                height: 40,
                child: CustomButton(
                  onTablet: false,
                  isLoading: model.isLoading,
                  onMobile: true,
                  isEnable: true,
                  onPressed: () => model.logInUser(_email, _password),
                  label: 'SIGN IN',
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have account ?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => model.navigateToSignUpPage(),
                        child: Text(
                          ' Register Here',
                          style: TextStyle(
                            color: Color(0xFF40A944),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Or Sign In with:',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      onPressed: null,
                      icon: Container(
                        height: 28,
                        width: 28,
                        child: Image.asset(
                          'assets/images/png-transparent-google-logo-g-suite-google-guava-google-plus-company-text-logo.png',
                        ),
                      ),
                      label: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      onPressed: null,
                      icon: Container(
                        height: 28,
                        width: 28,
                        child: Image.asset(
                          'assets/images/facebook.png',
                        ),
                      ),
                      label: Text(
                        'Sign in with Facebook',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
