import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';


class NavigationButtonButton extends StatefulWidget {
  final Function goHome;
  final Function goContact;
  final Function goAbout;
  NavigationButtonButton(
      {required this.goAbout, required this.goContact, required this.goHome});

  @override
  _NavigationButtonButtonState createState() => _NavigationButtonButtonState();
}

class _NavigationButtonButtonState extends State<NavigationButtonButton> {
  bool onHover = false;
  bool onHover1 = false;
  bool onHover2 = false;

  mouseEnter(bool state) {
    setState(() {
      onHover = state;
    });
  }

  mouseEnter1(bool state) {
    setState(() {
      onHover1 = state;
    });
  }

  mouseEnter2(bool state) {
    setState(() {
      onHover2 = state;
    });
  }

  Widget _navigationButton({
    required Function(bool) mouseEnter,
    required bool onHover,
    required Function onTap,
    required String label,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => mouseEnter(true),
        onExit: (e) => mouseEnter(false),
        child: Container(
          child: Text(
            '$label',
            style: menuTextStyle.copyWith(
              color: onHover ? accentColor : Colors.black,
              fontSize: SizeConfig.blockSizeHorizontal * 1.2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _navigationButton(
          label: 'Home',
          mouseEnter: (e) => mouseEnter(e),
          onHover: onHover,
          onTap: () => widget.goHome(),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 1.3,
        ),
        _navigationButton(
          label: 'Contact Us',
          mouseEnter: (e) => mouseEnter1(e),
          onHover: onHover1,
          onTap: () => widget.goContact(),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 1.3,
        ),
        _navigationButton(
          label: 'About Us',
          mouseEnter: (e) => mouseEnter2(e),
          onHover: onHover2,
          onTap: () => widget.goAbout(),
        ),
      ],
    );
  }
}