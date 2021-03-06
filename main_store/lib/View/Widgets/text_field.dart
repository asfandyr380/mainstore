import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';

class TextInputField extends StatelessWidget {
  final String hint_text;
  final Function(String?)? validateForm;
  final Function(String)? onChange;
  final TextInputType? type;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? mode;
  final bool? onMobile;
  final bool? onMobileappbar;
  final bool? onTablet;
  final bool? isObsocured;
  final TextEditingController? controller;
  TextInputField({
    this.type,
    this.controller,
    this.isObsocured,
    this.onTablet,
    this.onMobile,
    required this.hint_text,
    this.onChange,
    this.validateForm,
    this.onMobileappbar,
    this.formKey,
    this.mode,
  });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _onMobile = onMobile ?? false;
    bool _onMobileappbar = onMobileappbar ?? false;
    bool _onTablet = onTablet ?? false;
    bool _isObsocured = isObsocured ?? false;
    return Container(
      width: _onMobile
          ? double.infinity
          : _onTablet
              ? SizeConfig.blockSizeHorizontal * 37
              : SizeConfig.blockSizeHorizontal * 31,
      // height: _onMobile
      //     ? SizeConfig.blockSizeVertical * 5
      //     : SizeConfig.blockSizeVertical * 7,
      child: TextFormField(
        controller: controller,
        obscureText: _isObsocured,
        keyboardType: type,
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
    );
  }
}
