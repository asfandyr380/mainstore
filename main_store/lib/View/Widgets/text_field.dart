import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';

class TextInputField extends StatelessWidget {
  final String hint_text;
  final Function(String)? onChange;
  TextInputField({required this.hint_text, this.onChange});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 31,
      height: SizeConfig.blockSizeVertical * 7,
      child: TextFormField(
        onChanged: (val) => onChange!(val),
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
