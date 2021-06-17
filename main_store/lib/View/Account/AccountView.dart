import 'package:flutter/material.dart';
import 'package:main_store/View/Account/AccountViewModel.dart';
import 'package:stacked/stacked.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Text('Account'),
              ),
            ),
        viewModelBuilder: () => AccountViewModel());
  }
}
