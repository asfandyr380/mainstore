import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  CustomButton({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
            width: SizeConfig.blockSizeVertical * 62, height: 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: accentColor),
          onPressed: () {},
          child: Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
