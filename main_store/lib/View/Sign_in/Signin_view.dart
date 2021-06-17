import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Forum/Forum.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Sign_in/signin_viewModel.dart';
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
              Header(
                isSignInPage: true,
              ),
              Center(
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

class SignInMobile extends StatelessWidget {
  const SignInMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Scaffold(),
        viewModelBuilder: () => SigninViewModel());
  }
}
