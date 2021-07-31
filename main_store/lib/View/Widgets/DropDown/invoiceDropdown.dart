import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:stacked/stacked.dart';

import 'dropdownViewModel.dart';

class StatusDropdown extends StatefulWidget {
  final dynamic selectedState;
  final List<String>? items;
  final Function(String)? onChange;
  StatusDropdown({this.items, this.selectedState, this.onChange});
  @override
  _StatusDropdown createState() => _StatusDropdown();
}

class _StatusDropdown extends State<StatusDropdown> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DropDownViewModel>.reactive(
      viewModelBuilder: () => DropDownViewModel(),
      builder: (context, model, child) => Container(
        color: Colors.white,
        child: Container(
          height: SizeConfig.blockSizeVertical * 4,
          width: SizeConfig.blockSizeHorizontal * 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.5),
            border: Border.all(
              color: Colors.black,
              width: 0.25,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: widget.selectedState,
                    elevation: 8,
                    icon: Visibility(
                      visible: false,
                      child: Icon(
                        FontAwesomeIcons.chevronDown,
                        color: Colors.white,
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      color: Colors.white,
                    ),
                    onChanged: (newValue) => widget.onChange!(newValue!),
                    items: widget.items!
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            "$value",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize:
                                    SizeConfig.blockSizeHorizontal * 0.90),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.chevronDown,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
