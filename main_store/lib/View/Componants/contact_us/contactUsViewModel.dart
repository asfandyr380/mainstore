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
  TextEditingController controller = TextEditingController();
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
      controller.clear();
      return true;
    } else
      return false;
  }
}
