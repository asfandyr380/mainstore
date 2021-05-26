import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';

class TextInputField extends StatelessWidget {
  final String hint_text;
  TextInputField({required this.hint_text});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 31,
      height: SizeConfig.blockSizeVertical * 7,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint_text,
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
    );
  }
}
