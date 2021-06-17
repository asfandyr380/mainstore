import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';

class TextInputField extends StatelessWidget {
  final String hint_text;
  final Function(String?)? validateForm;
  final Function(String)? onChange;
  final bool? onMobile;
  TextInputField(
      {this.onMobile,
      required this.hint_text,
      this.onChange,
      this.validateForm});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool _onMobile = onMobile ?? false;
    return Form(
      // autovalidateMode: AutovalidateMode.always,
      child: Container(
        width:
            _onMobile ? double.infinity : SizeConfig.blockSizeHorizontal * 31,
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
              fontSize: _onMobile
                  ? SizeConfig.blockSizeHorizontal * 4
                  : SizeConfig.blockSizeHorizontal * 1,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.green),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 10),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );
  }
}
