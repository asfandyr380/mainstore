import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class QuickLinks extends StatefulWidget {
  final String pageName;
  final Function? onTap;
  QuickLinks({required this.pageName, this.onTap});

  @override
  _QuickLinksState createState() => _QuickLinksState();
}

class _QuickLinksState extends State<QuickLinks> {
  bool hovering = false;

  mouseEnter(bool state) {
    setState(() {
      hovering = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (e) => mouseEnter(true),
      onExit: (e) => mouseEnter(false),
      child: GestureDetector(
        onTap: () => widget.onTap!(),
        child: Container(
          padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 0.6,
          ),
          alignment: Alignment.topLeft,
          child: Text(
            widget.pageName,
            style: TextStyle(
                color: hovering ? accentColor : null,
                fontSize: SizeConfig.blockSizeHorizontal * 1,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }
}
