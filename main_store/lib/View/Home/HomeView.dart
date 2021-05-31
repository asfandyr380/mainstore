import 'package:flutter/material.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/SwipeBanner/SwipeBannerView.dart';
import 'package:main_store/View/Home/HomeViewModel.dart';
import 'package:stacked/stacked.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Header(
                  onTap: () {},
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SwipeBanner(),
                  ],
                ),
              ),
              Container(
                child: Footer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
