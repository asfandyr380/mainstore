import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Sign_in/signin_viewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/src/material/input_border.dart';
import 'package:flutter/src/material/input_decorator.dart';
import 'package:flutter/src/material/dropdown.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  List<String> item = ['Groceries', '1', '2', '3'];
  List<String> item1 = ['Top Brands', '1', '2', '3'];
  List<String> item2 = ['House Holds', '1', '2', '3'];
  List<String> item3 = ['Recipes', '1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SigninViewModel>.reactive(
      viewModelBuilder: () => SigninViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            // header 1st row
            Row(
              children: [
                SizedBox(width: 50),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.facebookF, size: 15),
                    SizedBox(width: 10),
                    Icon(FontAwesomeIcons.twitter, size: 15),
                    SizedBox(width: 10),
                    Icon(FontAwesomeIcons.instagram, size: 15),
                    SizedBox(width: 10),
                    Icon(FontAwesomeIcons.pinterestP, size: 15),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 600),
                    Text('Free Shipping Over 12\$ Order'),
                  ],
                )
              ],
            ),
            // Second Row with logo search box and contact
            Row(
              children: [
                SizedBox(width: 80),
                Image.asset(
                  '/Users/hamidu/StudioProjects/mainstore/main_store/assets/images/logo.png',
                  height: 150,
                  width: 150,
                ),
                // SEARCHBOX ****
                SizedBox(width: 300),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 500,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Product...',
                          hintStyle: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF959595),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff40a944),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      child: Icon(
                        FontAwesomeIcons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xff40a944),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                    ),
                  ],
                ),
                SizedBox(width: 400),

                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.phoneVolume,
                      size: 30,
                      color: Color(0xff40a944),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '07304137580',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Customer Support',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            //LISTVIEW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(child: Text('Home')),
                Dropdown(
                    items: item,
                    onChange: (newVal) =>
                        model.onDropDownChange(newVal, item[0]),
                    dropdownVal: item[0]),
                Dropdown(
                    items: item1,
                    onChange: (newVal) =>
                        model.onDropDownChange(newVal, item1[0]),
                    dropdownVal: item1[0]),
                Dropdown(
                    items: item2,
                    onChange: (newVal) =>
                        model.onDropDownChange(newVal, item2[0]),
                    dropdownVal: item2[0]),
                Dropdown(
                    items: item3,
                    onChange: (newVal) =>
                        model.onDropDownChange(newVal, item3[0]),
                    dropdownVal: item3[0]),
                Container(child: Text('About Us')),
                Container(child: Text('Contact Us')),
                // Container(
                //   child: Row(
                //     children: [
                //       Text('LOGIN'),
                //       SizedBox(
                //         width: 20,
                //       ),
                //       Icon(FontAwesomeIcons.heart),
                //       SizedBox(
                //         width: 20,
                //       ),
                //       Expanded(child: Icon(FontAwesomeIcons.shoppingCart)),
                //     ],
                //   ),
                // )
              ],
            ),
            // Row(
            //   children: [],
            // ),
            // Row(
            //   children: [],
            // ),
            // Row(
            //   children: [],
            // ),
          ],
        ),
      ),
    );
  }
}

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

// TextField(
//     decoration: InputDecoration(
//       hintText: 'Search Product...',
//       hintStyle: TextStyle(color: Color(0xFF959595),)

//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Color(0xFF959595),
//           width: 1,
//         ),

//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(10),
//           bottomRight: Radius.circular(0),
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(0),
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Color(0xFF959595),
//           width: 1,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(10),
//           bottomRight: Radius.circular(0),
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(0),
//         ),
//       ),

//     ),
//     style: TextStyle(color: Color(0xFF959595), FontWeight fontWeight,)
//   ),
