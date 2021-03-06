import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String? label;
  final bool? isEnable;
  final bool? isLoading;
  final bool? onMobile;
  final bool? onTablet;
  CustomButton(
      {this.isEnable,
      this.onMobile,
      this.onTablet,
      required this.onPressed,
      required this.label,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _isEnable = isEnable ?? false;
    bool _isLoading = isLoading ?? false;
    bool _onMobile = onMobile ?? false;
    bool _onTablet = onTablet ?? false;
    String _label = label ?? '';
    SizeConfig().init(context);
    return Container(
      width: _onTablet
          ? SizeConfig.blockSizeHorizontal * 38
          : SizeConfig.blockSizeHorizontal * 30,
      height: SizeConfig.blockSizeVertical * 5,
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
                _label,
                style: TextStyle(
                  fontSize: _onMobile
                      ? SizeConfig.blockSizeHorizontal * 3.5
                      : SizeConfig.blockSizeHorizontal * 1,
                ),
              ),
      ),
    );
  }
}
