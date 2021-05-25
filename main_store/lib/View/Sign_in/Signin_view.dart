import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Sign_in/signin_viewModel.dart';
import 'package:stacked/stacked.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SigninViewModel>.reactive(
      viewModelBuilder: () => SigninViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [],
                ),
                Row(
                  children: [],
                ),
                Row(
                  children: [],
                ),
                Row(
                  children: [],
                ),
                Row(
                  children: [],
                ),
                Row(
                  children: [],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
