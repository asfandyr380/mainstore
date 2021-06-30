import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/About_Us/AboutViewModel.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:stacked/stacked.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AboutViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Header(
                isSignInPage: true,
              ),
            ),
            // // About Us Page
            AboutUsDetails(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            // Footer,
            Container(
              child: Footer(),
            )
          ],
        ),
      ),
    );
  }
}

class AboutUsDetails extends StatelessWidget {
  const AboutUsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
            child: Text(
              'About Us',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
              child: Container(
                height: SizeConfig.blockSizeVertical * 30,
                width: SizeConfig.blockSizeVertical * 30,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 4, color: Colors.grey.shade500),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/grocerystore.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeVertical * 5,
              ),
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 45,
                child: Text(
                  '$aboutUSText',
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 1.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
