import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterViewModel.dart';
import 'package:main_store/View/Widgets/QuickLinks.dart';
import 'package:stacked/stacked.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => FooterViewModel(),
      builder: (context, model, child) => Container(
        width: double.infinity,
        height: SizeConfig.blockSizeVertical * 25,
        decoration: BoxDecoration(color: footerColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Image
                Container(
                  width: SizeConfig.blockSizeHorizontal * 9,
                  height: SizeConfig.blockSizeVertical * 15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 1.5),
                  child: FittedBox(
                    child: Text(
                      footer_desc,
                      maxLines: 10,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
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
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 30),
                width: SizeConfig.blockSizeHorizontal * 25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      alignment: Alignment.topLeft,
                      child: FittedBox(
                        child: Text(
                          'Quick Links',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w300),
                        ),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: VerticalDivider(
                color: Colors.grey,
              ),
            ),
            // Download App Column
            Expanded(
              child: Container(
                height: SizeConfig.blockSizeVertical * 25,
                width: SizeConfig.blockSizeHorizontal * 25,
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      child: FittedBox(
                        child: Text(
                          'Download App',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        'assets/images/47q2YGt.png',
                        width: SizeConfig.blockSizeHorizontal * 10,
                        height: SizeConfig.blockSizeVertical * 8,
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        'assets/images/nkZP7fe.png',
                        width: SizeConfig.blockSizeHorizontal * 10,
                        height: SizeConfig.blockSizeVertical * 8,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
