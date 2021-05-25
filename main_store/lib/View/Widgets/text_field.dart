import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String hint_text;
  TextInputField({required this.hint_text});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint_text,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.green),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 10),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
