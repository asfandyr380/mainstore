import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/MessageModel.dart';
import 'package:main_store/Services/Api/Messages/messagesServices.dart';

class ContactUsViewModel extends ChangeNotifier {
  MessageServices _messageServices = locator<MessageServices>();
  String firstName = '';
  String lastname = '';
  String email = '';
  String phone = '';
  String message = '';
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  AutovalidateMode mode = AutovalidateMode.disabled;

  validateForm(String? val) {
    if (val!.isEmpty) {
      return "This field Cannot be Empty";
    }
  }

  validateInputs() {
    final form = key.currentState;
    if (form!.validate()) {
      return 1;
    } else {
      mode = AutovalidateMode.onUserInteraction;
      notifyListeners();
    }
  }

  Future sendForum() async {
    MessageModel model = MessageModel(
      email: email,
      name: '${firstName + lastname}',
      phone: phone,
      message: message,
    );
    Map<String, dynamic> body = model.toJson();
    var result = await _messageServices.sendMessage(body);
    if (result == 1) {
      firstController.clear();
      lastController.clear();
      emailController.clear();
      phoneController.clear();
      msgController.clear();
      return true;
    } else
      return false;
  }
}
