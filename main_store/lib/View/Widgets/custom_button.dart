import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String label;
  final bool? isEnable;
  final bool? isLoading;
  final bool? onMobile;
  CustomButton(
      {this.isEnable,
      this.onMobile,
      required this.onPressed,
      required this.label,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _isEnable = isEnable ?? false;
    bool _isLoading = isLoading ?? false;
    bool _onMobile = onMobile ?? false;
    SizeConfig().init(context);
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          width: SizeConfig.blockSizeHorizontal * 30,
          height: SizeConfig.blockSizeVertical * 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: accentColor),
        onPressed: _isEnable
            ? () {
                onPressed!();
              }
            : null,
        child: _isLoading
            ? Container(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: _onMobile
                      ? SizeConfig.blockSizeHorizontal * 4.5
                      : SizeConfig.blockSizeHorizontal * 1,
                ),
              ),
      ),
    );
  }
}
