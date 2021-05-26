import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Forum.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Sign_up/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Header(),
              Center(child: Forum()),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Footer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
