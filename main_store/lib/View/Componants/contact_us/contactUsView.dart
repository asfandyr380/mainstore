import 'package:flutter/material.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/Header/Header.dart';
import 'package:main_store/View/Componants/contact_us/contactUsViewModel.dart';
import 'package:main_store/View/Widgets/custom_button.dart';
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
              Header(),
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
                    TextInputField(hint_text: 'Email'),
                    TextInputField(hint_text: 'Phone Number'),
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
                      height: SizeConfig.blockSizeVertical * 1.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 34.5),
                      child: Row(
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 15,
                            child: CustomButton(
                              onPressed: null,
                              label: 'Contact Us',
                              isEnable: true,
                            ),
                          ),
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
