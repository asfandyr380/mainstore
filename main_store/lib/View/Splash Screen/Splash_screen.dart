import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/View/Splash%20Screen/SplashViewModel.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        onModelReady: (model) => model.navigateToHome(),
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Container(
                  child: CircularProgressIndicator(
                    color: accentColor,
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => SplashViewModel());
  }
}
