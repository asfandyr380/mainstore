import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/View/Widgets/text_field.dart';

AppBar mobileAppBar(GlobalKey<ScaffoldState> scaffoldKey) {
  return AppBar(
    backgroundColor: accentColor,
    title: TextInputField(
      onMobileappbar: true,
      hint_text: 'Search Products',
      onMobile: true,
    ),
    leading: IconButton(
      onPressed: () async {
        scaffoldKey.currentState?.openDrawer();
      },
      icon: FaIcon(
        FontAwesomeIcons.alignJustify,
        color: Colors.white70,
        size: 30,
      ),
    ),
  );
}
