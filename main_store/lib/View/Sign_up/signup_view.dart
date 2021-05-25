import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Forum.dart';
import 'package:main_store/View/Sign_up/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(child: Forum()),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeConfig.blockSizeVertical * 25,
      decoration: BoxDecoration(color: footerColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Logo Image
              Container(
                height: 40,
              ),
              Container(
                child: Text(footer_desc, style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: VerticalDivider(
              color: Colors.grey,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Quick Links',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                child: Text(
                  'About',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                child: Text(
                  'Contact',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                child: Text(
                  'Terms & Condition',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: VerticalDivider(
              color: Colors.grey,
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Download App',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
