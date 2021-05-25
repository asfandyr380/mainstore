import 'package:flutter/material.dart';
import 'package:main_store/View/Sign_up/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          child: Text('Sign Up Page'),
        ),
      ),
    );
  }
}
