import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Componants/Header/header_view.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/SuccessPage/success_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class Success extends StatelessWidget {
  String? id;
  var routeData;
  Success(this.id, {this.routeData});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SuccessPageViewModel>.reactive(
      viewModelBuilder: () => SuccessPageViewModel(),
      onModelReady: (m) => m.init(id, routeData),
      builder: (context, model, _) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                  )
                ],
              ),
              child: Header(type: HeaderViewType.searchable),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: SizeConfig.blockSizeVertical * 12,
                  width: SizeConfig.blockSizeHorizontal * 12,
                  decoration: BoxDecoration(
                    color: accentColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(FontAwesomeIcons.check, color: Colors.white),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Text(
                  'Your Order Has Successfully been Placed',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 1,
                  ),
                ),
              ],
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
