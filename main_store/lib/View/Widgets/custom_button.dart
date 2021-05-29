import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final bool? isEnable;
  CustomButton({this.isEnable, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    bool _isEnable = isEnable ?? false;
    SizeConfig().init(context);
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          width: SizeConfig.blockSizeHorizontal * 30,
          height: SizeConfig.blockSizeVertical * 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: accentColor),
        onPressed: _isEnable
            ? () {
                onPressed();
              }
            : null,
        child: Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
