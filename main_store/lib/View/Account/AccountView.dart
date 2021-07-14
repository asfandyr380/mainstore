import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Account/AccountViewModel.dart';
import 'package:main_store/View/Home/HomeView.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';
import 'package:main_store/View/Sign_up/signup_view.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';

class AccountView extends StatelessWidget {
  final bool? onSignIn;
  final bool? onSignUp;
  AccountView({this.onSignIn, this.onSignUp});
  @override
  Widget build(BuildContext context) {
    bool _onSignIn = onSignIn ?? false;
    bool _onSignUp = onSignUp ?? false;
    return ViewModelBuilder<AccountViewModel>.reactive(
        builder: (context, model, child) {
          if (_onSignIn)
            return SignInMobileView();
          else if (_onSignUp)
            return SignUpMobile();
          else
            return HomeMobile();
        },
        viewModelBuilder: () => AccountViewModel());
  }
}
