import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Forum/Forum.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Sign_in/signin_viewModel.dart';
import 'package:main_store/View/Widgets/Mobile_AppBar.dart';
import 'package:main_store/View/Widgets/custom_button.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  isSignIn: true,
                  onSignInClick: (email, pass) => model.signInUser(email, pass),
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
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SigninViewModel>.reactive(
      viewModelBuilder: () => SigninViewModel(),
      builder: (context, model, child) => Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          elevation: 16,
          // Drawer content to be added
          child: Center(
            child: Text('No Data'),
          ),
        ),
        appBar: mobileAppBar(scaffoldKey),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     IconButton(
              //       onPressed: () async {
              //         scaffoldKey.currentState?.openDrawer();
              //       },
              //       icon: FaIcon(
              //         FontAwesomeIcons.alignJustify,
              //         color: Colors.black,
              //         size: 30,
              //       ),
              //     ),
              //     Expanded(
              //       child: Padding(
              //         padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
              //         child: TextInputField(
              //           hint_text: 'Search Products',
              //           onMobile: true,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Lato',
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
                        fontFamily: 'Lato',
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
                  isEnable: true,
                  onPressed: () {
                    print('Button pressed ...');
                  },
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
                        fontFamily: 'Lato',
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Register Here',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: Color(0xFF40A944),
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
                        fontFamily: 'Lato',
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
                        child: Image.network(
                          'https://i0.wp.com/nanophorm.com/wp-content/uploads/2018/04/google-logo-icon-PNG-Transparent-Background.png?w=1000&ssl=1',
                        ),
                      ),
                      label: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontFamily: 'Lato',
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
                        child: Image.network(
                          'https://facebookbrand.com/wp-content/uploads/2019/04/f_logo_RGB-Hex-Blue_512.png?w=512&h=512',
                        ),
                      ),
                      label: Text(
                        'Sign in with Facebook',
                        style: TextStyle(
                          fontFamily: 'Lato',
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
