import 'package:flutter/material.dart';
import 'package:main_store/Componants/Header/header_view.dart';
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/sizeconfig.dart';
import 'package:main_store/View/Componants/Footer/FooterView.dart';
import 'package:main_store/View/Componants/contact_us/contactUsViewModel.dart';
import 'package:main_store/View/Widgets/text_field.dart';
import 'package:stacked/stacked.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ContactUsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ContactUsViewModel>.reactive(
      viewModelBuilder: () => ContactUsViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: model.key,
            autovalidateMode: model.mode,
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
                  child: Header(type: HeaderViewType.searchable),
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
                            child: TextInputField(
                              controller: model.firstController,
                              validateForm: (_) => model.validateForm(_),
                              hint_text: 'First Name',
                              onChange: (val) {
                                model.firstName = val;
                              },
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Container(
                              width: SizeConfig.blockSizeHorizontal * 15,
                              child: TextInputField(
                                controller: model.lastController,
                                validateForm: (_) => model.validateForm(_),
                                hint_text: 'Last Name',
                                onChange: (val) {
                                  model.lastname = val;
                                },
                              )),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      TextInputField(
                        controller: model.emailController,
                        validateForm: (_) => model.validateForm(_),
                        hint_text: 'Email',
                        onChange: (val) {
                          model.email = val;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      TextInputField(
                        controller: model.phoneController,
                        hint_text: 'Phone Number',
                        validateForm: (_) => model.validateForm(_),
                        onChange: (val) {
                          model.phone = val;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1.5,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 31,
                        child: TextFormField(
                          controller: model.msgController,
                          validator: (_) => model.validateForm(_),
                          onChanged: (val) {
                            model.message = val;
                          },
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
                              onPressed: () {
                                model.sendForum().then((value) {
                                  var result = model.validateInputs();
                                  if (result == 1) {
                                    if (value) {
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.success(
                                          message: 'Message Send Successfuly',
                                        ),
                                        displayDuration:
                                            Duration(milliseconds: 150),
                                      );
                                    }
                                  }
                                });
                              },
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
      ),
    );
  }
}
