import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Forum/Forum.dart';
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Header(),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Forum(
                  onClick: (email, pass, name, phone) =>
                      model.createNewUser(email, pass, name, phone),
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
