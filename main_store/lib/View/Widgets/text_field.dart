import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';

class TextInputField extends StatelessWidget {
  final String hint_text;
  final Function(String?)? validateForm;
  final Function(String)? onChange;
  final bool? onMobile;
  final bool? onMobileappbar;
  final bool? onTablet;

  TextInputField({
    this.onTablet,
    this.onMobile,
    required this.hint_text,
    this.onChange,
    this.validateForm,
    this.onMobileappbar,
  });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _onMobile = onMobile ?? false;
    bool _onMobileappbar = onMobileappbar ?? false;
    bool _onTablet = onTablet ?? false;
    return Form(
      // autovalidateMode: AutovalidateMode.always,
      child: Container(
        width: _onMobile
            ? double.infinity
            : _onTablet
                ? SizeConfig.blockSizeHorizontal * 37
                : SizeConfig.blockSizeHorizontal * 31,
        height: _onMobile
            ? SizeConfig.blockSizeVertical * 5
            : SizeConfig.blockSizeVertical * 7,
        child: TextFormField(
          validator: (value) => validateForm!(value),
          onChanged: (val) => onChange!(val),
          decoration: InputDecoration(
            hintText: hint_text,
            contentPadding: _onMobile
                ? EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 0,
                    left: SizeConfig.blockSizeHorizontal * 3)
                : null,
            hintStyle: TextStyle(
              color: _onMobileappbar ? Colors.white70 : Colors.grey,
              fontSize: _onMobile
                  ? SizeConfig.blockSizeHorizontal * 4
                  : SizeConfig.blockSizeHorizontal * 1,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: _onMobileappbar ? Colors.white70 : Colors.grey,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 10,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
