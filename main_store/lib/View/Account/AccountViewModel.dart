import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

class AccountViewModel extends ChangeNotifier {
  StorageServices _services = locator<StorageServices>();
  bool authState = false;
  checkUser() async {
    bool user = await _services.getUser();
    authState = user;
    notifyListeners();
  }
}
