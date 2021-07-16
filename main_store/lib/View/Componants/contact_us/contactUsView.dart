import 'package:flutter/material.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/contact_us/contactUsViewModel.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';

class ContactUsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ContactUsViewModel>.reactive(
      viewModelBuilder: () => ContactUsViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                  )
                ]),
                child: Header(),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeHorizontal * 2,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: SizeConfig.blockSizeHorizontal * 15,
                            child: TextInputField(hint_text: 'First Name')),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Container(
                            width: SizeConfig.blockSizeHorizontal * 15,
                            child: TextInputField(hint_text: 'Last Name')),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1.5,
                    ),
                    TextInputField(hint_text: 'Email'),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1.5,
                    ),
                    TextInputField(hint_text: 'Phone Number'),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1.5,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 31,
                      child: TextFormField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Message',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 34.5),
                      child: Row(
                        children: [
                          Container(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: accentColor,
                              fixedSize: Size(
                                SizeConfig.blockSizeHorizontal * 10,
                                SizeConfig.blockSizeVertical * 5,
                              ),
                            ),
                            onPressed: () {},
                            child: Text('Contact Us'),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 8,
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
