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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Image
                Container(
                  child: Image.asset(
                    '/Users/hamidu/StudioProjects/mainstore/main_store/assets/images/logo.png',
                    height: 150,
                    width: 150,
                  ),
                ),
                Expanded(
                  child: Container(
                      height: SizeConfig.blockSizeVertical * 10,
                      child: Text(footer_desc, style: TextStyle(fontSize: 12))),
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
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Quick Links',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
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
                  padding:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                  child: FittedBox(
                    child: Text(
                      'Download App',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Container(
                  child: Image.asset(
                    '/Users/hamidu/StudioProjects/mainstore/main_store/assets/images/47q2YGt.png',
                    width: SizeConfig.blockSizeHorizontal * 10,
                    height: SizeConfig.blockSizeVertical * 8,
                  ),
                ),
                Container(
                  child: Image.asset(
                    '/Users/hamidu/StudioProjects/mainstore/main_store/assets/images/nkZP7fe.png',
                    width: SizeConfig.blockSizeHorizontal * 10,
                    height: SizeConfig.blockSizeVertical * 8,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
