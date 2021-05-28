import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Forum.dart';
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
              Header(),
              Center(
                child: Forum(
                  isSignIn: true,
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
