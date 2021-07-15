import 'package:flutter/material.dart';
import 'package:main_store/View/Account/AccountViewModel.dart';
import 'package:main_store/View/Sign_in/Signin_view.dart';
import 'package:main_store/View/Sign_up/signup_view.dart';
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
        onModelReady: (model) => model.checkUser(),
        builder: (context, model, child) {
          if (_onSignIn)
            return SignInMobileView();
          else if (_onSignUp)
            return SignUpMobile();
          else
            return model.authState ? AccountPage() : SignInMobileView();
        },
        viewModelBuilder: () => AccountViewModel());
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Account Page'),
      ),
    );
  }
}
