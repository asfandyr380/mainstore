import 'package:flutter/material.dart';
import 'package:main_store/View/Sign_in/signin_viewModel.dart';
import 'package:stacked/stacked.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SigninViewModel>.reactive(
      viewModelBuilder: () => SigninViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${model.counter}',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: model.incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
