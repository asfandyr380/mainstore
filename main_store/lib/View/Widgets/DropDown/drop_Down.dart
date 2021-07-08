import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/View/Widgets/DropDown/dropdownViewModel.dart';
import 'package:stacked/stacked.dart';

class Dropdown extends StatelessWidget {
  final List<String> items;
  final Function(String)? orderBy;
  Dropdown({required this.items, this.orderBy});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DropDownViewModel>.reactive(
      viewModelBuilder: () => DropDownViewModel(),
      builder: (context, model, child) => Container(
        child: Row(
          children: [
            DropdownButton<String>(
              value: model.dropDownVal,
              icon: Icon(
                FontAwesomeIcons.chevronDown,
                color: footerColor,
              ),
              iconSize: 15,
              elevation: 8,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                color: Colors.white,
              ),
              onChanged: (String? newValue) =>
                  model.onChange(newValue!).then((value) => orderBy!(value)),
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
            Icon(
              FontAwesomeIcons.chevronDown,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
