import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      builder: (context, model, child) => Column(
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.blockSizeVertical * 25,
            decoration: BoxDecoration(color: footerColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Logo and Site Desription
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo Image
                    Container(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                        height: SizeConfig.blockSizeVertical * 10,
                        width: SizeConfig.blockSizeHorizontal * 10,
                      ),
                    ),
                    // Site Description
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 35,
                      height: SizeConfig.blockSizeVertical * 12,
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1.5),
                      child: Text(
                        footer_desc,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 0.9,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: VerticalDivider(
                    color: Colors.grey,
                  ),
                ),
                // Quick Links Column
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      width: SizeConfig.blockSizeHorizontal * 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                            ),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Quick Links',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 2,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          QuickLinks(pageName: 'Home'),
                          QuickLinks(pageName: 'About'),
                          QuickLinks(pageName: 'Contact'),
                        ],
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Our Polices',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 2,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          QuickLinks(pageName: 'Privicy Policy'),
                          QuickLinks(pageName: 'Terms & Condition'),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: VerticalDivider(
                    color: Colors.grey,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 1,
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Follow Us',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 2,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SocialLinkofFooter(
                            icon: FontAwesomeIcons.facebookF,
                            color: Colors.blueAccent[700],
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          SocialLinkofFooter(
                            icon: FontAwesomeIcons.instagram,
                            color: Colors.blueAccent[700],
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          SocialLinkofFooter(
                            icon: FontAwesomeIcons.linkedin,
                            color: Colors.lightBlue[900],
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          SocialLinkofFooter(
                            icon: FontAwesomeIcons.link,
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.phoneAlt),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text('030000000')
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.envelope),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text('example@email.com')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 0.5),
            decoration: BoxDecoration(
              color: footerColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -0.5),
                  color: Colors.grey,
                )
              ],
            ),
            child: Text(
              '© 2021 Family Super Mart All Rights Reserved.',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialLinkofFooter extends StatelessWidget {
  final IconData? icon;
  final String? link;
  final Color? color;
  SocialLinkofFooter({this.icon, this.link, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: SizeConfig.blockSizeHorizontal * 1.3,
      color: color,
    );
  }
}
