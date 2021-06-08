import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/View/Widgets/DropDown/dropdownViewModel.dart';
import 'package:stacked/stacked.dart';

class Dropdown extends StatelessWidget {
  final String dropdownVal;
  final List<String> items;
  Dropdown({required this.items, required this.dropdownVal});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DropDownViewModel>.reactive(
      viewModelBuilder: () => DropDownViewModel(),
      builder: (context, model, child) => Container(
        child: DropdownButton<String>(
          value: model.currentValue,
          icon: const Icon(FontAwesomeIcons.chevronDown),
          iconSize: 15,
          elevation: 8,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            color: Colors.white,
          ),
          onChanged: (String? newValue) =>
              model.onChange(dropdownVal, newValue!),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
