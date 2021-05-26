import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dropdown extends StatelessWidget {
  final Function(String?) onChange;
  final String dropdownVal;
  final List<String> items;
  Dropdown(
      {required this.items, required this.onChange, required this.dropdownVal});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: dropdownVal,
        icon: const Icon(FontAwesomeIcons.chevronDown),
        iconSize: 15,
        elevation: 15,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          color: Colors.white,
        ),
        onChanged: (String? newValue) => onChange(newValue),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
