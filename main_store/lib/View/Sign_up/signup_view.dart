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
    SizeConfig().init(context);
    return Container(
      width: double.infinity,
      height: SizeConfig.blockSizeVertical * 25,
      decoration: BoxDecoration(color: footerColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: VerticalDivider(
              color: Colors.grey,
            ),
          ),
          // Quick Links Column
          Container(
            width: SizeConfig.blockSizeHorizontal * 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Quick Links',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(child: QuickLinks(pageName: 'Home')),
                Expanded(child: QuickLinks(pageName: 'About')),
                Expanded(child: QuickLinks(pageName: 'Contact')),
                Expanded(child: QuickLinks(pageName: 'Privacy Policy')),
                Expanded(child: QuickLinks(pageName: 'Terms & Condition')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: VerticalDivider(
              color: Colors.grey,
            ),
          ),
          // Download App Column
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                child: FittedBox(
                  child: Text(
                    'Download App',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuickLinks extends StatelessWidget {
  final String pageName;
  QuickLinks({required this.pageName});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6),
      alignment: Alignment.topLeft,
      child: FittedBox(
        child: Text(
          pageName,
          style: TextStyle(fontSize: 15, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
